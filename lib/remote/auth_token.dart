class AuthToken {
  final String token;
  final String accessExpiry;

  AuthToken(this.token, this.accessExpiry);

  AuthToken.fromJson(Map<String, dynamic> json)
      : token = json["access_token"],
        accessExpiry = json["access_expiry"];
}
