import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/task.dart';

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
}
