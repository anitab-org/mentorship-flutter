class AuthToken {
  final String token;
  final double accessExpiry;

  AuthToken(this.token, this.accessExpiry);

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      AuthToken(json["access_token"], json["access_expiry"]);
}
