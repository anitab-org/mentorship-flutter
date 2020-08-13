import 'package:mentorship_client/remote/models/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_stats.g.dart';

/// This class represents statistics of the user actions on the app.
/// [name] the name of the user
/// [pending_requests] number of pending requests
/// [accepted_requests] number of accepted requests
/// [completed_relations] number of completed relations
/// [cancelled_relations] number of cancelled relations
/// [rejected_requests] number of rejected requests
/// [achievements] a list of up-to 3 completed tasks

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeStats {
  final String name;
  final int pendingRequests;
  final int acceptedRequests;
  final int completedRelations;
  final int cancelledRelations;
  final int rejectedRequests;
  final List<Task> achievements;

  HomeStats({
    this.name,
    this.pendingRequests,
    this.acceptedRequests,
    this.completedRelations,
    this.cancelledRelations,
    this.rejectedRequests,
    this.achievements,
  })  : assert(name != null),
        assert(pendingRequests != null),
        assert(acceptedRequests != null),
        assert(completedRelations != null),
        assert(cancelledRelations != null),
        assert(rejectedRequests != null);

  // factory HomeStats.fromJson(Map<String, dynamic> json) => HomeStats(
  //       name: json["name"],
  //       pending_requests: json["pending_requests"],
  //       accepted_requests: json["accepted_requests"],
  //       completed_relations: json["completed_relations"],
  //       cancelled_relations: json["cancelled_relations"],
  //       rejected_requests: json["rejected_requests"],
  //       achievements: Task.fromAchievements(json["achievements"]),
  //     );

  factory HomeStats.fromJson(Map<String, dynamic> json) => _$HomeStatsFromJson(json);
  Map<String, dynamic> toJson() => _$HomeStatsToJson(this);
}
