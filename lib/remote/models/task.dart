import 'package:json_annotation/json_annotation.dart';
part 'task.g.dart';

/// This data class represents a task related to a mentorship
/// relation.
///
/// [id] The id of this task
/// [description] The description of this task
/// [isDone] Represents whether this task has been completed
/// [createdAt] Unix timestamp of when this task was created
/// [completedAt] Unix timestamp of when this task was completed
@JsonSerializable(fieldRename: FieldRename.snake)
class Task {
  final int id;
  final String description;
  final bool isDone;
  final double createdAt;
  final double completedAt;

  Task({
    this.id,
    this.description,
    this.isDone,
    this.createdAt,
    this.completedAt,
  })  : assert(id != null),
        assert(description != null),
        assert(isDone != null);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
  // factory Task.fromJson(Map<String, dynamic> json) => Task(
  //       id: json["id"],
  //       description: json["description"],
  //       isDone: json["is_done"],
  //       createdAt: json["created_at"],
  //       completedAt: json["completed_at"],
  //     );

  // static List<Task> fromAchievements(List<dynamic> taskList) {
  //   List<Task> achievements = [];
  //   for (dynamic taskJson in taskList) {
  //     achievements.add(Task.fromJson(taskJson));
  //   }
  //   return achievements;
  // }

  static List<Task> tasks(List<dynamic> taskList) {
    List<Task> tasks = [];
    for (dynamic taskJson in taskList) {
      tasks.add(Task.fromJson(taskJson));
    }
    return tasks;
  }
}
