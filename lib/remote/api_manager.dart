import 'package:mentorship_client/remote/services/auth_service.dart';

class ApiManager {
  static final instance = ApiManager._internal();

  final AuthService authService = AuthService.create();

  ApiManager._internal();
}
