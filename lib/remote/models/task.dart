/// This data class represents a task related to a mentorship
/// relation.
///
/// [id] The id of this task
/// [description] The description of this task
/// [isDone] Represents whether this task has been completed
/// [createdAt] Unix timestamp of when this task was created
/// [completedAt] Unix timestamp of when this task was completed
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

  static List<Task> fromAchievements(List<dynamic> taskList) {
    List<Task> achievements = [];
    for (dynamic task in taskList) {
      achievements.add(Task(
        id: task["id"],
        description: task["description"],
        isDone: task["is_done"],
        createdAt: task["created_at"],
        completedAt: task["completed_at"],
      ));
    }
    return achievements;
  }
}
