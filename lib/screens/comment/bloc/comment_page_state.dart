import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/comment.dart';

abstract class CommentPageState extends Equatable {
  final String message;

  const CommentPageState({this.message});

  @override
  List<Object> get props => [message];
}

class CommentPageInitial extends CommentPageState {
  CommentPageInitial({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class CommentPageLoading extends CommentPageState {
  CommentPageLoading({String message}) : super(message: message);
}

class CommentPageSuccess extends CommentPageState {
  // final Relation relation;
  // final int taskId;
  final List<Comment> comments;

  CommentPageSuccess(this.comments, {String message}) : super(message: message);

  @override
  List<Object> get props => [message, comments];
}

class CommentPageFailure extends CommentPageState {
  CommentPageFailure({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
