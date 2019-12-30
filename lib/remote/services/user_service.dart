import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';
import 'package:mentorship_client/remote/auth_interceptor.dart';
import 'package:mentorship_client/remote/models/user.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class UserService extends ChopperService {
  /// Returns the current user's home screen statistics
  @Get(path: "home")
  Future<Response<Map<String, dynamic>>> getHomeStats();

  /// Returns all users, with email verified, of the system
  @Get(path: "users/verified")
  Future<Response<List<dynamic>>> getVerifiedUsers();

  /// Returns the current user profile
  @Get(path: "user")
  Future<Response<Map<String, dynamic>>> getCurrentUser();

  /// Returns a specified user's public profile of the system
  @Get(path: "user/{userId}")
  Future<Response<Map<String, dynamic>>> getUser(@Path("userId") int userId);

  /// Updates the current user's profile
  @Put(path: "user")
  Future<Response<Map<String, dynamic>>> updateUser(@Body() User user);

  static UserService create() {
    final client = ChopperClient(
        baseUrl: API_URL,
        services: [
          _$UserService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          AuthInterceptor(),
        ]);

    return _$UserService(client);
  }
}
