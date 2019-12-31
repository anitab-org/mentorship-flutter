import 'dart:io';

import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/requests/login.dart';
import 'package:mentorship_client/remote/requests/register.dart';
import 'package:mentorship_client/remote/responses/auth_token.dart';
import 'package:universal_html/prefer_universal/html.dart';

/// Repository taking care of authentication. Its main task is to serve as an abstraction
/// layer over [AuthService]. [AuthRepository] exposes following actions:
/// - user login and logout
/// - user registration
/// - persisting JWT tokens
/// - deleting JWT tokens
class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();
  static const AUTH_TOKEN = "auth-token";

  AuthRepository._internal();

  Future<AuthToken> login(Login login) async {
    try {
      final response = await ApiManager.instance.authService.login(login);

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      final AuthToken authToken = AuthToken.fromJson(response.body);

      return authToken;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> register(Register register) async {
    try {
      final response = await ApiManager.instance.authService.register(register);

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteToken() async {
    Logger.root.info("Deleted token. UNSUPPORTED ON WEB");
  }

  void persistToken(String token) => (token == null)
      ? window.localStorage.remove('SessionId')
      : window.localStorage['SessionId'] = "Bearer $token";

  String getToken() {
    final String token = window.localStorage['SessionId'];

    if (token != null) {
      Logger.root.info("Has token!");
    } else {
      Logger.root.info("Does not have token!");
    }

    return token;
  }
}
