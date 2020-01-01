import 'package:mentorship_client/remote/services/auth_service.dart';
import 'package:mentorship_client/remote/services/relation_service.dart';
import 'package:mentorship_client/remote/services/user_service.dart';

/// Singleton class that gathers all services in one place.
class ApiManager {
  static final instance = ApiManager._internal();

  final AuthService authService = AuthService.create();
  final UserService userService = UserService.create();
  final RelationService relationService = RelationService.create();

  ApiManager._internal();
}
