import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/task.dart';
import 'package:mentorship_client/remote/requests/task_request.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

class TaskRepository {
  static final TaskRepository instance = TaskRepository._internal();

  TaskRepository._internal();

  /// Returns all the tasks from a mentorship relation
  /// [relationId] id of the mentorship relation
  Future<List<Task>> getAllTasks(int relationId) async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.taskService.getAllTasksFromMentorshipRelation(relationId));
    List<Task> tasks = [];

    for (var user in body) {
      tasks.add(Task.fromJson(user));
    }

    return tasks;
  }

  Future<CustomResponse> createTask(int relationId, TaskRequest taskRequest) async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.taskService.createTask(relationId, taskRequest));

    return CustomResponse.fromJson(body);
  }

  Future<CustomResponse> completeTask(int relationId, int taskId) async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.taskService.completeTask(relationId, taskId));

    return CustomResponse.fromJson(body);
  }

  Future<CustomResponse> deleteTask(int relationId, int taskId) async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.taskService.deleteTask(relationId, taskId));

    return CustomResponse.fromJson(body);
  }
}
