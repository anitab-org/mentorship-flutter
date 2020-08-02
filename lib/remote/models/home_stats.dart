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

@JsonSerializable()
class HomeStats {
  final String name;
  final int pending_requests;
  final int accepted_requests;
  final int completed_relations;
  final int cancelled_relations;
  final int rejected_requests;
  final List<Task> achievements;

  HomeStats({
    this.name,
    this.pending_requests,
    this.accepted_requests,
    this.completed_relations,
    this.cancelled_relations,
    this.rejected_requests,
    this.achievements,
  })  : assert(name != null),
        assert(pending_requests != null),
        assert(accepted_requests != null),
        assert(completed_relations != null),
        assert(cancelled_relations != null),
        assert(rejected_requests != null);

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
