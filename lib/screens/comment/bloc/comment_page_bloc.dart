import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/comment.dart';
import 'package:mentorship_client/remote/repositories/comment_repository.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/repositories/task_repository.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';
import 'bloc.dart';

class CommentPageBloc extends Bloc<CommentPageEvent, CommentPageState> {
  final RelationRepository relationRepository;
  final TaskRepository taskRepository;
  final CommentRepository commentRepository;
  CommentPageBloc(this.relationRepository, this.taskRepository, this.commentRepository)
      : super(CommentPageInitial());

  @override
  Stream<CommentPageState> mapEventToState(CommentPageEvent event) async* {
    if (event is CommentPageShowed) {
      yield CommentPageInitial();
      try {
        List<Comment> comments =
            await commentRepository.getAllComments(event.relation.id, event.taskId);
        yield CommentPageSuccess(comments);
      } on Failure catch (failure) {
        Logger.root.severe("CommentPageBloc: ${failure.message}");
        yield CommentPageFailure(message: failure.message);
      }
    }
    if (event is CommentCreated) {
      try {
        CustomResponse response = await commentRepository.newComment(
            event.relation.id, event.taskId, event.commentRequest);
        var comments = await commentRepository.getAllComments(event.relation.id, event.taskId);
        yield CommentPageSuccess(comments, message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe("CommentPageBloc: ${failure.message}");
        yield CommentPageFailure(message: failure.message);
      }
    }
    if (event is CommentDeleted) {
      try {
        CustomResponse response =
            await commentRepository.deleteCommemt(event.relation.id, event.taskId, event.commentId);
        var comments = await commentRepository.getAllComments(event.relation.id, event.taskId);
        yield CommentPageSuccess(comments, message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe("CommentPageBloc: ${failure.message}");
        yield CommentPageFailure(message: failure.message);
      }
    }
  }
}
