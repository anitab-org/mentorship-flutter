import 'package:mentorship_client/remote/services/auth_service.dart';
import 'package:mentorship_client/remote/services/relation_service.dart';
import 'package:mentorship_client/remote/services/user_service.dart';
import 'package:mentorship_client/typedefs.dart';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';

/// Singleton class that gathers all services in one place.
class ApiManager {
  static final instance = ApiManager._internal();

  final AuthService authService = AuthService.create();
  final UserService userService = UserService.create();
  final RelationService relationService = RelationService.create();

  ApiManager._internal();

  /// Convenience method to reduce boilerplate. Invokes API function
  /// and catches all possible errors.
  static Future<T> callSafely<T>(ApiFunction apiFunction) async {
    try {
      final response = await apiFunction();

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      return response.body;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }
}
