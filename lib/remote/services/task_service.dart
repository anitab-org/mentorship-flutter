import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';
import 'package:mentorship_client/remote/auth_interceptor.dart';
import 'package:mentorship_client/remote/requests/task_request.dart';

part 'task_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class TaskService extends ChopperService {
  /// Returns all the tasks from a mentorship relation
  /// [relationId] id of the mentorship relation
  @Get(path: "mentorship_relation/{relation_id}/tasks")
  Future<Response<List<dynamic>>> getAllTasksFromMentorshipRelation(
      @Path("relation_id") int relationId);

  @Post(path: "mentorship_relation/{request_id}/task")
  Future<Response<Map<String, dynamic>>> createTask(
      @Path("request_id") int requestId, @Body() TaskRequest taskRequest);

  @Put(path: "mentorship_relation/{request_id}/task/{task_id}/complete")
  Future<Response<Map<String, dynamic>>> completeTask(
      @Path("request_id") int requestId, @Path("task_id") int taskId);

  @Delete(path: "mentorship_relation/{request_id}/task/{task_id}")
  Future<Response<Map<String, dynamic>>> deleteTask(
      @Path("request_id") int requestId, @Path("task_id") int taskId);

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
