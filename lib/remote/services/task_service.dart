import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';
import 'package:mentorship_client/remote/auth_interceptor.dart';

part 'task_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class TaskService extends ChopperService {
  /// Returns all the tasks from a mentorship relation
  /// [relationId] id of the mentorship relation
  @Get(path: "mentorship_relation/{relation_id}/tasks")
  Future<Response<List<dynamic>>> getAllTasksFromMentorshipRelation(@Path("relation_id") int relationId);

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
