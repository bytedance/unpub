import 'package:shelf/shelf.dart' as shelf;

abstract class OAuthProvider {
  /// A forward proxy uri
  final Uri? proxyOrigin;

  final String? overrideUploaderEmail;

  OAuthProvider({
    this.proxyOrigin,
    this.overrideUploaderEmail,
  });

  Future<String> getUploaderEmail(Map<String, String> httpHeaders);

  /// Whether or not to allow the calling request.
  ///
  /// Return null to allow request
  /// or
  /// return OAuthProvider.unauthorized('i have no idea who you are');
  /// return OAuthProvider.forbidden('you dont have permission');
  ///
  /// https://github.com/dart-lang/pub/blob/master/doc/repository-spec-v2.md#missing-authentication-or-invalid-token
  Future<shelf.Response?> shouldAllowRequest(shelf.Request req);

  static shelf.Response unauthorized(String messageForPubClient) {
    return shelf.Response(401, headers: {
      'WWW-Authenticate': 'Bearer realm="pub", message="$messageForPubClient"'
    });
  }

  static shelf.Response forbidden(String messageForPubClient) {
    return shelf.Response(403, headers: {
      'WWW-Authenticate': 'Bearer realm="pub", message="$messageForPubClient"'
    });
  }
}
