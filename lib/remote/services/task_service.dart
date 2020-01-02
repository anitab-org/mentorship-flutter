import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';
import 'package:mentorship_client/remote/auth_interceptor.dart';
import 'package:mentorship_client/remote/requests/relation_requests.dart';

part 'task_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class TaskService extends ChopperService {
  /// Returns all mentorship requests and relations of the current user
  @Get(path: "mentorship_relations")
  Future<Response<List<dynamic>>> getAllTasksFromMentorshipRelation();

  static TaskService create() {
    final client = ChopperClient(
        baseUrl: API_URL,
        services: [
          _$TaskService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          AuthInterceptor(),
        ]);

    return _$TaskService(client);
  }
}
