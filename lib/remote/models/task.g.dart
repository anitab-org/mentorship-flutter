// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as int,
    description: json['description'] as String,
    isDone: json['is_done'] as bool,
    createdAt: (json['created_at'] as num)?.toDouble(),
    completedAt: (json['completed_at'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'is_done': instance.isDone,
      'created_at': instance.createdAt,
      'completed_at': instance.completedAt,
    };
