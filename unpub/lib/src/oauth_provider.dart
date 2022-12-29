
abstract class OAuthProvider {
  /// A forward proxy uri
  final Uri? proxyOrigin;

  final String? overrideUploaderEmail;

  OAuthProvider({
    this.proxyOrigin,
    this.overrideUploaderEmail,
  });

  Future<String> getUploaderEmail(Map<String, String> httpHeaders);
}
