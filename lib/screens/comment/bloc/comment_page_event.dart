import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/requests/comment_request.dart';

abstract class CommentPageEvent extends Equatable {
  const CommentPageEvent();
}

class CommentPageShowed extends CommentPageEvent {
  final Relation relation;
  final int taskId;

  CommentPageShowed(this.relation, this.taskId);
  @override
  List<Object> get props => [relation, taskId];
}

// class CommentPageRefresh extends CommentPageEvent {
//   @override
//   List<Object> get props => null;
// }

class CommentCreated extends CommentPageEvent {
  final Relation relation;
  final int taskId;
  final CommentRequest commentRequest;

  CommentCreated(this.relation, this.taskId, this.commentRequest);

  @override
  List<Object> get props => [relation, taskId, commentRequest];
}

class CommentDeleted extends CommentPageEvent {
  final Relation relation;
  final int taskId;
  final int commentId;

  CommentDeleted(this.relation, this.taskId, this.commentId);

  @override
  List<Object> get props => [relation, taskId];
}
