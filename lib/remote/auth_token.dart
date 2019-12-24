class AuthToken {
  final String token;
  final String accessExpiry;

  AuthToken(this.token, this.accessExpiry);

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    print("auth token json: $json");
    return AuthToken(json["access_token"], json["access_expiry"]);
  }
}
