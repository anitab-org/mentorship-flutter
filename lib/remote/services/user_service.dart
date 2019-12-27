import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';

part 'user_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class UserService extends ChopperService {
  @Get(path: "home")
  Future<Response<Map<String, dynamic>>> getHomeStats();

  static UserService create() {
    final client = ChopperClient(
        baseUrl: API_URL,
        services: [
          _$UserService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
        ]);

    return _$UserService(client);
  }
}
