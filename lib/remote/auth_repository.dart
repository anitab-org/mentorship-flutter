import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/requests/login.dart';
import 'package:mentorship_client/remote/requests/register.dart';
import 'package:mentorship_client/remote/models/auth_token.dart';

class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();
  static const AUTH_TOKEN = "auth-token";
  final _storage = FlutterSecureStorage();

  AuthRepository._internal();

  Future<AuthToken> login(Login login) async {
    try {
      final response = await ApiManager.instance.authService.login(login);

      if (!response.isSuccessful) {
        print("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      final AuthToken authToken = AuthToken.fromJson(response.body);

      return authToken;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    }
  }

  Future<Object> register(Register register) async {
    final response = await ApiManager.instance.authService.register(register);

    return response.body;
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: AUTH_TOKEN);
    Logger.root.info("Deleted token.");
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: AUTH_TOKEN, value: "Bearer $token");
    Logger.root.info("Persisted token.");
  }

  Future<String> getToken() async {
    final String token = await _storage.read(key: AUTH_TOKEN);

    if (token != null) {
      Logger.root.info("Has token!");
    } else {
      Logger.root.info("Does not have token!");
    }

    return token;
  }
}
