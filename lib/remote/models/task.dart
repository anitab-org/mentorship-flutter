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
@JsonSerializable()
class Task {
  final int id;
  final String description;
  final bool is_done;
  final double created_at;
  final double completed_at;

  Task({
    this.id,
    this.description,
    this.is_done,
    this.created_at,
    this.completed_at,
  })  : assert(id != null),
        assert(description != null),
        assert(is_done != null);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
  // factory Task.fromJson(Map<String, dynamic> json) => Task(
  //       id: json["id"],
  //       description: json["description"],
  //       isDone: json["is_done"],
  //       createdAt: json["created_at"],
  //       completedAt: json["completed_at"],
  //     );

  static List<Task> fromAchievements(List<dynamic> taskList) {
    List<Task> achievements = [];
    for (dynamic taskJson in taskList) {
      achievements.add(Task.fromJson(taskJson));
    }
    return achievements;
  }
}
