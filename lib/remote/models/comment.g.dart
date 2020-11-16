// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    json['id'] as int,
    json['user_id'] as int,
    json['task_id'] as int,
    json['relation_id'] as int,
    (json['creation_date'] as num)?.toDouble(),
    (json['modification_date'] as num)?.toDouble(),
    json['comment'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'task_id': instance.taskId,
      'relation_id': instance.relationId,
      'creation_date': instance.creationDate,
      'modification_date': instance.modificationDate,
      'comment': instance.comment,
    };
