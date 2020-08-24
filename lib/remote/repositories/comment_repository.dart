import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/comment.dart';
import 'package:mentorship_client/remote/requests/comment_request.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

class CommentRepository {
  static final CommentRepository instance = CommentRepository._internal();

  CommentRepository._internal();

  Future<List<Comment>> getAllComments(int relationId, int taskId) async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.commentService.getAllComments(relationId, taskId));
    List<Comment> comments = [];

    for (var json in body) {
      comments.add(Comment.fromJson(json));
    }

    return comments;
  }

  Future<CustomResponse> newComment(
      int relationId, int taskId, CommentRequest commentRequest) async {
    final body = await ApiManager.callSafely(() => ApiManager.instance.commentService.newComment(
          relationId,
          taskId,
          commentRequest,
        ));

    return CustomResponse.fromJson(body);
  }

  Future<CustomResponse> editComment(int relationId, int taskId, int commentId) async {
    final body = await ApiManager.callSafely(() => ApiManager.instance.commentService.editComment(
          relationId,
          taskId,
          commentId,
        ));

    return CustomResponse.fromJson(body);
  }

  Future<CustomResponse> deleteCommemt(int relationId, int taskId, int commentId) async {
    final body = await ApiManager.callSafely(() => ApiManager.instance.commentService.deleteComment(
          relationId,
          taskId,
          commentId,
        ));

    return CustomResponse.fromJson(body);
  }
}
