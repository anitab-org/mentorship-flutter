import 'package:mentorship_client/remote/services/auth_service.dart';

class ApiManager {
  static final _instance = ApiManager._internal();

  final AuthService authService = AuthService.create();

  factory ApiManager() {
    return _instance;
  }

  ApiManager._internal();
}
