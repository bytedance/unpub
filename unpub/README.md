# Unpub

[![pub](https://img.shields.io/pub/v/unpub.svg)](https://pub.dev/packages/unpub)
[![test](https://github.com/bytedance/unpub/workflows/test/badge.svg)](https://github.com/bytedance/unpub/actions?query=workflow:test)

Unpub is a self-hosted private Dart Pub server for Enterprise, with a simple web interface to search and view packages information.

## Fix

You need to upload the lib/src/static/style.css file to your server, and then upload the file in lib/src/static/index.html.dart http://xxxxx/style.css Just change to the style.css address of your server(你需要将lib/src/static/style.css文件上传到自己的服务器,然后将lib/src/static/index.html.dart里面的http://xxxxx/style.css换成你服务器的style.css的地址即可)


## Screenshots

![Screenshot](https://raw.githubusercontent.com/bytedance/unpub/master/assets/screenshot.png)

## Usage via command line

```sh
pub global activate unpub
unpub --database mongodb://localhost:27017/dart_pub # Replace this with production database uri
```

Unpub use mongodb as meta information store and file system as package(tarball) store by default.

Dart API is also available for further customization.

## Usage via Dart API

### Example

```dart
import 'package:unpub/unpub.dart' as unpub;

main(List<String> args) async {
  var basedir = '/path/to/basedir'; // Base directory to save pacakges
  var db = 'mongodb://localhost:27017/dart_pub'; // MongoDB uri

  var metaStore = unpub.MongoStore(db);
  await metaStore.db.open();

  var packageStore = unpub.FileStore(basedir);

  var app = unpub.App(
    metaStore: metaStore,
    packageStore: packageStore,
  );

  var server = await app.serve('0.0.0.0', 4000);
  print('Serving at http://${server.address.host}:${server.port}');
}
```

### Options

| Option                    | Description                                                                          | Default         |
| ------------------------- | ------------------------------------------------------------------------------------ | --------------- |
| `metaStore` (Required)    | Meta information store                                                               | -               |
| `packageStore` (Required) | Package(tarball) store                                                               | -               |
| `upstream`                | Upstream url                                                                         | https://pub.dev |
| `googleapisProxy`         | Http(s) proxy to call googleapis (to get uploader email)                             | -               |
| `overrideUploaderEmail`   | If specified, unpub will use this email as uploader instead of requesting googleapis | -               |
| `uploadValidator`         | See [Package validator](#package-validator)                                          | -               |

### Package validator

Naming conflicts is a common issue for private registry. A reasonable solution is to add prefix to reduce conflict probability.

With `uploadValidator` you could check if uploaded package is valid.

```dart
var app = unpub.App(
  // ...
  uploadValidator: (Map<String, dynamic> pubspec, String uploaderEmail) {
    // Only allow packages with some specified prefixes to be uploaded
    var prefix = 'my_awesome_prefix_';
    var name = pubspec['name'] as String;
    if (!name.startsWith(prefix)) {
      throw 'Package name should starts with $prefix';
    }

    // Also, you can check if uploader email is valid
    if (!uploaderEmail.endsWith('@your-company.com')) {
      throw 'Uploader email invalid';
    }
  }
);
```

### Customize meta and package store

Unpub is designed to be extensible. It is quite easy to customize your own meta store and package store.

```dart
import 'package:unpub/unpub.dart' as unpub;

class MyAwesomeMetaStore extends unpub.MetaStore {
  // Implement methods of MetaStore abstract class
  // ...
}

class MyAwesomePackageStore extends unpub.PackageStore {
  // Implement methods of PackageStore abstract class
  // ...
}

// Then use it
var app = unpub.App(
  metaStore: MyAwesomeMetaStore(),
  packageStore: MyAwesomePackageStore(),
)
```

## Badges

| URL                                          | Badge                                                                                     |
| -------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `/badge/v/{package_name}` | ![badge example](https://img.shields.io/static/v1?label=unpub&message=0.1.0&color=orange) ![badge example](https://img.shields.io/static/v1?label=unpub&message=1.0.0&color=blue) |
| `/badge/d/{package_name}`                    | ![badge example](https://img.shields.io/static/v1?label=downloads&message=123&color=blue) |

## Alternatives

- [pub-dev](https://github.com/dart-lang/pub-dev): Source code of [pub.dev](https://pub.dev), which should be deployed at Google Cloud Platform.
- [pub_server](https://github.com/dart-lang/pub_server): An alpha version of pub server provided by Dart team.

## Credits

- [pub-dev](https://github.com/dart-lang/pub-dev): Web page styles are mostly imported from https://pub.dev directly.
- [shields](https://shields.io): Badges generation.

## License

MIT
