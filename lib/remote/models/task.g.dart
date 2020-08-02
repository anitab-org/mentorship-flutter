// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as int,
    description: json['description'] as String,
    is_done: json['is_done'] as bool,
    created_at: (json['created_at'] as num)?.toDouble(),
    completed_at: (json['completed_at'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'is_done': instance.is_done,
      'created_at': instance.created_at,
      'completed_at': instance.completed_at,
    };
