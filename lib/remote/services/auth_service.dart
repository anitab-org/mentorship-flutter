import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';
import 'package:mentorship_client/remote/requests/login.dart';
import 'package:mentorship_client/remote/requests/register.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class AuthService extends ChopperService {
  @Post(path: "login")
  Future<Response<Map<String, dynamic>>> login(@Body() Login login);

  @Post(path: "register")
  Future<Response<Object>> register(@Body() Register register);

  static AuthService create() {
    final client = ChopperClient(
        baseUrl: API_URL,
        services: [
          _$AuthService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
        ]);

    return _$AuthService(client);
  }
}
