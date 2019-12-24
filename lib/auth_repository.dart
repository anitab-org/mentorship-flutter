import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/auth_token.dart';
import 'package:mentorship_client/remote/requests/login.dart';
import 'package:mentorship_client/remote/requests/register.dart';

class AuthRepository {
  Future<AuthToken> login(Login login) async {
    var response = await ApiManager().authService.login(login);

    return response.body;
  }

  Future<Object> register(Register register) async {
    var response = await ApiManager().authService.register(register);

    return response.body;
  }
}
