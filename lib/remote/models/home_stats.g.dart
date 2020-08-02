// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeStats _$HomeStatsFromJson(Map<String, dynamic> json) {
  return HomeStats(
    name: json['name'] as String,
    pending_requests: json['pending_requests'] as int,
    accepted_requests: json['accepted_requests'] as int,
    completed_relations: json['completed_relations'] as int,
    cancelled_relations: json['cancelled_relations'] as int,
    rejected_requests: json['rejected_requests'] as int,
    achievements: (json['achievements'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeStatsToJson(HomeStats instance) => <String, dynamic>{
      'name': instance.name,
      'pending_requests': instance.pending_requests,
      'accepted_requests': instance.accepted_requests,
      'completed_relations': instance.completed_relations,
      'cancelled_relations': instance.cancelled_relations,
      'rejected_requests': instance.rejected_requests,
      'achievements': instance.achievements,
    };
