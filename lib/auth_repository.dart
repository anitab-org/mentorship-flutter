import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/auth_token.dart';
import 'package:mentorship_client/remote/requests/login.dart';
import 'package:mentorship_client/remote/requests/register.dart';

class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();

  AuthRepository._internal();

  Future<AuthToken> login(Login login) async {
    var response = await ApiManager.instance.authService.login(login);

    return response.body;
  }

  Future<Object> register(Register register) async {
    var response = await ApiManager.instance.authService.register(register);

    return response.body;
  }
}
