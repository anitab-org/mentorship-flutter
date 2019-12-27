import 'package:mentorship_client/remote/services/auth_service.dart';
import 'package:mentorship_client/remote/services/user_service.dart';

class ApiManager {
  static final instance = ApiManager._internal();

  final AuthService authService = AuthService.create();
  final UserService userService = UserService.create();

  ApiManager._internal();
}
