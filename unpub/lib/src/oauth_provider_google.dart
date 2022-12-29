import 'dart:io';

import 'package:googleapis/oauth2/v2.dart';
import 'package:http/io_client.dart';
import 'package:unpub/src/oauth_provider.dart';
import 'package:http/http.dart' as http;

class GoogleOAuthProvider extends OAuthProvider {
  GoogleOAuthProvider({
    this.googleapisProxy,
    Uri? proxyOrigin,
    String? overrideUploaderEmail,
  }) : super(
          proxyOrigin: proxyOrigin,
          overrideUploaderEmail: overrideUploaderEmail,
        );

  http.Client? _googleapisClient;

  /// http(s) proxy to call googleapis (to get uploader email)
  final String? googleapisProxy;

  @override
  Future<String> getUploaderEmail(Map<String, String> httpHeaders) async {
    if (overrideUploaderEmail != null) return overrideUploaderEmail!;

    var authHeader = httpHeaders[HttpHeaders.authorizationHeader];
    if (authHeader == null) throw 'missing authorization header';

    var token = authHeader.split(' ').last;

    if (_googleapisClient == null) {
      if (googleapisProxy != null) {
        _googleapisClient = IOClient(
          HttpClient()
            ..findProxy = (url) => HttpClient.findProxyFromEnvironment(
                  url,
                  environment: {
                    "https_proxy": googleapisProxy!,
                  },
                ),
        );
      } else {
        _googleapisClient = http.Client();
      }
    }

    var info = await Oauth2Api(
      _googleapisClient!,
    ).tokeninfo(
      accessToken: token,
    );
    if (info.email == null) throw 'failed to get google account email';
    return info.email!;
  }
}
