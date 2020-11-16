import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class Comment {
  final int id;
  final int userId;
  final int taskId;
  final int relationId;
  final double creationDate;
  final double modificationDate;
  final String comment;

  Comment(this.id, this.userId, this.taskId, this.relationId, this.creationDate,
      this.modificationDate, this.comment);
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
