// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeStats _$HomeStatsFromJson(Map<String, dynamic> json) {
  return HomeStats(
    name: json['name'] as String,
    pendingRequests: json['pending_requests'] as int,
    acceptedRequests: json['accepted_requests'] as int,
    completedRelations: json['completed_relations'] as int,
    cancelledRelations: json['cancelled_relations'] as int,
    rejectedRequests: json['rejected_requests'] as int,
    achievements: (json['achievements'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeStatsToJson(HomeStats instance) => <String, dynamic>{
      'name': instance.name,
      'pending_requests': instance.pendingRequests,
      'accepted_requests': instance.acceptedRequests,
      'completed_relations': instance.completedRelations,
      'cancelled_relations': instance.cancelledRelations,
      'rejected_requests': instance.rejectedRequests,
      'achievements': instance.achievements,
    };
