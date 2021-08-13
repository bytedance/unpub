import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:googleapis/oauth2/v2.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:pub_semver/pub_semver.dart' as semver;
import 'package:archive/archive.dart';
import 'package:unpub/src/models.dart';
import 'package:unpub/unpub_api/lib/models.dart';
import 'package:unpub/src/meta_store.dart';
import 'package:unpub/src/package_store.dart';
import 'utils.dart';
import 'static/index.html.dart' as index_html;
import 'static/main.dart.js.dart' as main_dart_js;
import 'static/style.dart.css.dart' as style_dart_css;

part 'app.g.dart';

class App {
  final MetaStore metaStore;
  final PackageStore packageStore;
  final String upstream;
  final String googleapisProxy;
  final String overrideUploaderEmail;
  final Future<void> Function(
      Map<String, dynamic> pubspec, String uploaderEmail) uploadValidator;

  App({
    @required this.metaStore,
    @required this.packageStore,
    this.upstream = 'https://pub.dev',
    this.googleapisProxy,
    this.overrideUploaderEmail,
    this.uploadValidator,
  });

  static shelf.Response _okWithJson(Map<String, dynamic> data) =>
      shelf.Response.ok(
        json.encode(data),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Access-Control-Allow-Origin': '*'
        },
      );

  static shelf.Response _successMessage(String message) => _okWithJson({
        'success': {'message': message}
      });

  static shelf.Response _badRequest(String message,
          {int status = HttpStatus.badRequest}) =>
      shelf.Response(
        status,
        headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType},
        body: json.encode({
          'error': {'message': message}
        }),
      );

  http.Client _googleapisClient;

  Future<String> _getUploaderEmail(shelf.Request req) async {
    if (overrideUploaderEmail != null) return overrideUploaderEmail;

    var authHeader = req.headers[HttpHeaders.authorizationHeader];
    if (authHeader == null) return null;

    var token = authHeader.split(' ').last;

    if (_googleapisClient == null) {
      if (googleapisProxy != null) {
        _googleapisClient = IOClient(HttpClient()
          ..findProxy = (url) => HttpClient.findProxyFromEnvironment(url,
              environment: {"https_proxy": googleapisProxy}));
      } else {
        _googleapisClient = http.Client();
      }
    }

    var info = await Oauth2Api(_googleapisClient).tokeninfo(accessToken: token);
    if (info == null) return null;
    return info.email;
  }

  Future<HttpServer> serve([String host = '0.0.0.0', int port = 4000]) async {
    var handler = const shelf.Pipeline()
        .addMiddleware(shelf.logRequests())
        .addHandler((req) async {
      // Return 404 by default
      // https://github.com/google/dart-neats/issues/1
      var res = await router.handler(req);
      if (res == null) {
        return shelf.Response.notFound('Not found');
      } else {
        return res;
      }
    });
    var server = await shelf_io.serve(handler, host, port);
    return server;
  }

  Map<String, dynamic> _versionToJson(UnpubVersion item, Uri baseUri) {
    var name = item.pubspec['name'] as String;
    var version = item.version;
    return {
      'archive_url': baseUri
          .resolve('/packages/$name/versions/$version.tar.gz')
          .toString(),
      'pubspec': item.pubspec,
      'version': version,
    };
  }

  bool isPubClient(shelf.Request req) {
    var ua = req.headers[HttpHeaders.userAgentHeader];
    return ua != null && ua.toLowerCase().contains('dart pub');
  }

  Router get router => _$AppRouter(this);

  @Route.get('/api/packages/<name>')
  Future<shelf.Response> getVersions(shelf.Request req, String name) async {
    var package = await metaStore.queryPackage(name);

    if (package == null) {
      return shelf.Response.found(
          Uri.parse(upstream).resolve('/api/packages/$name').toString());
    }

    package.versions.sort((a, b) {
      return semver.Version.prioritize(
          semver.Version.parse(a.version), semver.Version.parse(b.version));
    });

    var versionMaps = package.versions
        .map((item) => _versionToJson(item, req.requestedUri))
        .toList();

    return _okWithJson({
      'name': name,
      'latest': versionMaps.last, // TODO: Exclude pre release
      'versions': versionMaps,
    });
  }

  @Route.get('/api/packages/<name>/versions/<version>')
  Future<shelf.Response> getVersion(
      shelf.Request req, String name, String version) async {
    // Important: + -> %2B, should be decoded here
    try {
      version = Uri.decodeComponent(version);
    } catch (err) {
      print(err);
    }

    var package = await metaStore.queryPackage(name);
    if (package == null) {
      return shelf.Response.found(Uri.parse(upstream)
          .resolve('/api/packages/$name/versions/$version')
          .toString());
    }

    var packageVersion = package.versions
        .firstWhere((item) => item.version == version, orElse: () => null);
    if (packageVersion == null) {
      return shelf.Response.notFound('Not Found');
    }

    return _okWithJson(_versionToJson(packageVersion, req.requestedUri));
  }

  @Route.get('/packages/<name>/versions/<version>.tar.gz')
  Future<shelf.Response> download(
      shelf.Request req, String name, String version) async {
    var package = await metaStore.queryPackage(name);
    if (package == null) {
      return shelf.Response.found(Uri.parse(upstream)
          .resolve('/packages/$name/versions/$version.tar.gz')
          .toString());
    }

    if (isPubClient(req)) {
      metaStore.increaseDownloads(name, version);
    }

    if (packageStore.supportsDownloadUrl) {
      return shelf.Response.found(packageStore.downloadUrl(name, version));
    } else {
      return shelf.Response.ok(
        packageStore.download(name, version),
        headers: {HttpHeaders.contentTypeHeader: ContentType.binary.mimeType},
      );
    }
  }

  @Route.get('/api/packages/versions/new')
  Future<shelf.Response> getUploadUrl(shelf.Request req) async {
    return _okWithJson({
      'url': req.requestedUri
          .resolve('/api/packages/versions/newUpload')
          .toString(),
      'fields': {},
    });
  }

  @Route.post('/api/packages/versions/newUpload')
  Future<shelf.Response> upload(shelf.Request req) async {
    try {
      var email = await _getUploaderEmail(req);

      var mediaType = MediaType.parse(req.headers['content-type']);

      var boundary = mediaType.parameters['boundary'];
      MimeMultipart fileData;

      await for (MimeMultipart part
          in req.read().transform(MimeMultipartTransformer(boundary))) {
        if (fileData != null) continue;
        fileData = part;
      }

      var bb = await fileData.fold(
          BytesBuilder(), (BytesBuilder byteBuilder, d) => byteBuilder..add(d));
      var tarballBytes = bb.takeBytes();
      var tarBytes = GZipDecoder().decodeBytes(tarballBytes);
      var archive = TarDecoder().decodeBytes(tarBytes);
      ArchiveFile pubspecArchiveFile;
      ArchiveFile readmeFile;
      ArchiveFile changelogFile;

      for (var file in archive.files) {
        if (file.name == 'pubspec.yaml') {
          pubspecArchiveFile = file;
          continue;
        }
        if (file.name.toLowerCase() == 'readme.md') {
          readmeFile = file;
          continue;
        }
        if (file.name.toLowerCase() == 'changelog.md') {
          changelogFile = file;
          continue;
        }
      }

      if (pubspecArchiveFile == null) {
        throw 'Did not find any pubspec.yaml file in upload. Aborting.';
      }

      var pubspecYaml = utf8.decode(pubspecArchiveFile.content);
      var pubspec = loadYamlAsMap(pubspecYaml);

      if (uploadValidator != null) {
        await uploadValidator(pubspec, email);
      }

      var name = pubspec['name'] as String;
      var version = pubspec['version'] as String;

      var package = await metaStore.queryPackage(name);

      // Package already exists
      if (package != null) {
        if (package.private != true) {
          throw '$name is not a private package. Please upload it to https://pub.dev';
        }

        // Check uploaders
        if (!package.uploaders.contains(email)) {
          throw '$email is not an uploader of $name';
        }

        // Check duplicated version
        var duplicated = package.versions
            .firstWhere((item) => version == item.version, orElse: () => null);
        if (duplicated != null) {
          throw 'version invalid: $name@$version already exists.';
        }
      }

      // Upload package tarball to storage
      await packageStore.upload(name, version, tarballBytes);

      String readme;
      String changelog;
      if (readmeFile != null) {
        readme = utf8.decode(readmeFile.content);
      }
      if (changelogFile != null) {
        changelog = utf8.decode(changelogFile.content);
      }
      // Write package meta to database
      var unpubVersion = UnpubVersion(
        pubspec['version'] as String,
        pubspec,
        pubspecYaml,
        readme,
        changelog,
        email,
        DateTime.now(),
      );

      await metaStore.addVersion(name, unpubVersion);


      // TODO: Upload docs
      return shelf.Response.found(req.requestedUri
          .resolve('/api/packages/versions/newUploadFinish')
          .toString());
    } catch (err) {
      return shelf.Response.found(req.requestedUri
          .resolve('/api/packages/versions/newUploadFinish?error=$err'));
    }
  }




  @Route.get('/api/packages/versions/newUploadFinish')
  Future<shelf.Response> uploadFinish(shelf.Request req) async {
    var error = req.requestedUri.queryParameters['error'];
    if (error != null) {
      return _badRequest(error);
    }
    return _successMessage('Successfully uploaded package.');
  }

  @Route.post('/api/packages/<name>/uploaders')
  Future<shelf.Response> addUploader(shelf.Request req, String name) async {
    var body = await req.readAsString();
    var email = Uri.splitQueryString(body)['email'];
    var operatorEmail = await _getUploaderEmail(req);
    var package = await metaStore.queryPackage(name);

    if (!package.uploaders.contains(operatorEmail)) {
      return _badRequest('no permission', status: HttpStatus.forbidden);
    }
    if (package.uploaders.contains(email)) {
      return _badRequest('email already exists');
    }

    await metaStore.addUploader(name, email);
    return _successMessage('uploader added');
  }

  @Route.delete('/api/packages/<name>/uploaders/<email>')
  Future<shelf.Response> removeUploader(
      shelf.Request req, String name, String email) async {
    email = Uri.decodeComponent(email);
    var operatorEmail = await _getUploaderEmail(req);
    var package = await metaStore.queryPackage(name);

    if (!package.uploaders.contains(operatorEmail)) {
      return _badRequest('no permission', status: HttpStatus.forbidden);
    }
    if (!package.uploaders.contains(email)) {
      return _badRequest('email not uploader');
    }

    await metaStore.removeUploader(name, email);
    return _successMessage('uploader removed');
  }

  @Route.get('/webapi/packages')
  Future<shelf.Response> getPackages(shelf.Request req) async {
    var params = req.requestedUri.queryParameters;
    var size = int.tryParse(params['size'] ?? '') ?? 10;
    var page = int.tryParse(params['page'] ?? '') ?? 0;
    var sort = params['sort'] ?? 'download';
    var q = params['q'];

    var count = await metaStore.queryCount(q);
    if (count == 0) {
      return _okWithJson({'data': ListApi(0, []).toJson()});
    }

    var packages =
        await metaStore.queryPackages(size, page, sort, q).map((package) {
      var latest = package.versions.last;

      return ListApiPackage(
        package.name,
        latest.pubspec['description'] as String,
        getPackageTags(latest.pubspec),
        latest.version,
        package.updatedAt,
      );
    }).toList();
    var data = ListApi(count, packages);

    return _okWithJson({'data': data.toJson()});
  }

  @Route.get('/webapi/package/<name>/<version>')
  Future<shelf.Response> getPackageDetail(
      shelf.Request req, String name, String version) async {
    var package = await metaStore.queryPackage(name);
    if (package == null) {
      return _okWithJson({'error': 'package not exists'});
    }

    UnpubVersion packageVersion;
    if (version == 'latest') {
      packageVersion = package.versions.last;
    } else {
      packageVersion = package.versions
          .firstWhere((item) => item.version == version, orElse: () => null);
    }
    if (packageVersion == null) {
      return _okWithJson({'error': 'version not exists'});
    }

    var versions = package.versions
        .map((v) => DetailViewVersion(v.version, v.createdAt))
        .toList();
    versions.sort((a, b) {
      return semver.Version.prioritize(
          semver.Version.parse(b.version), semver.Version.parse(a.version));
    });

    var pubspec = packageVersion.pubspec;
    List<String> authors;
    if (pubspec['author'] != null) {
      authors = RegExp(r'<(.*?)>')
          .allMatches(pubspec['author'])
          .map((match) => match.group(1))
          .toList();
    } else if (pubspec['authors'] != null) {
      authors = (pubspec['authors'] as List)
          .map((author) => RegExp(r'<(.*?)>').firstMatch(author).group(1))
          .toList();
    } else {
      authors = [];
    }

    var depMap = (pubspec['dependencies'] as Map ?? {}).cast<String, String>();

    var data = WebapiDetailView(
      package.name,
      packageVersion.version,
      packageVersion.pubspec['description'] ?? '',
      packageVersion.pubspec['homepage'] ?? '',
      package.uploaders,
      packageVersion.createdAt,
      packageVersion.readme,
      packageVersion.changelog,
      versions,
      authors,
      depMap.keys.toList(),
      getPackageTags(packageVersion.pubspec),
    );

    return _okWithJson({'data': data.toJson()});
  }

  @Route.get('/')
  @Route.get('/packages')
  @Route.get('/packages/<name>')
  @Route.get('/packages/<name>/versions/<version>')
  Future<shelf.Response> indexHtml(shelf.Request req) async {
    return shelf.Response.ok(index_html.content,
        headers: {HttpHeaders.contentTypeHeader: ContentType.html.mimeType});
  }

  @Route.get('/main.dart.js')
  Future<shelf.Response> mainDartJs(shelf.Request req) async {
    return shelf.Response.ok(main_dart_js.content,
        headers: {HttpHeaders.contentTypeHeader: 'text/javascript'});
  }

  @Route.get('/style.dart.css')
  Future<shelf.Response> styleDartCss(shelf.Request req) async {
    return shelf.Response.ok(style_dart_css.content,
        headers: {HttpHeaders.contentTypeHeader: 'text/css'});
  }

  String _getBadgeUrl(String label, String message, String color,
      Map<String, String> queryParameters) {
    var badgeUri = Uri.parse('https://img.shields.io/static/v1');
    return Uri(
        scheme: badgeUri.scheme,
        host: badgeUri.host,
        path: badgeUri.path,
        queryParameters: {
          'label': label,
          'message': message,
          'color': color,
          ...queryParameters,
        }).toString();
  }

  @Route.get('/badge/<type>/<name>')
  Future<shelf.Response> badge(
      shelf.Request req, String type, String name) async {
    var queryParameters = req.requestedUri.queryParameters;
    var package = await metaStore.queryPackage(name);
    if (package == null) {
      return shelf.Response.notFound('Not found');
    }

    switch (type) {
      case 'v':
        var latest = semver.Version.primary(package.versions
            .map((pv) => semver.Version.parse(pv.version))
            .toList());

        var color = latest.major == 0 ? 'orange' : 'blue';

        return shelf.Response.found(
            _getBadgeUrl('unpub', latest.toString(), color, queryParameters));
      case 'd':
        return shelf.Response.found(_getBadgeUrl(
            'downloads', package.download.toString(), 'blue', queryParameters));
      default:
        return shelf.Response.notFound('Not found');
    }
  }
}
