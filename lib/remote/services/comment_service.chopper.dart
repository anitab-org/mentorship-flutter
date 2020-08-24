// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CommentService extends CommentService {
  _$CommentService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CommentService;

  @override
  Future<Response<List<dynamic>>> getAllComments(int relationId, int taskId) {
    final $url = 'mentorship_relation/$relationId/task/$taskId/comments';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<dynamic>, List<dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> newComment(
      int relationId, int taskId, CommentRequest commentRequest) {
    final $url = 'mentorship_relation/$relationId/task/$taskId/comment';
    final $body = commentRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> editComment(
      int relationId, int taskId, int commentId) {
    final $url =
        'mentorship_relation/$relationId/task/$taskId/comment/$commentId';
    final $request = Request('PUT', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> deleteComment(
      int relationId, int taskId, int commentId) {
    final $url =
        'mentorship_relation/$relationId/task/$taskId/comment/$commentId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
