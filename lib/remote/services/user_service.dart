import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';
import 'package:mentorship_client/remote/auth_interceptor.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class UserService extends ChopperService {
  @Get(path: "home")
  Future<Response<Map<String, dynamic>>> getHomeStats();

  @Get(path: "users/verified")
  Future<Response<List<dynamic>>> getVerifiedUsers();

  @Get(path: "user")
  Future<Response<Map<String, dynamic>>> getUser();

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
