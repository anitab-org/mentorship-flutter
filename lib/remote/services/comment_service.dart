import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';
import 'package:mentorship_client/remote/auth_interceptor.dart';
import 'package:mentorship_client/remote/requests/comment_request.dart';

part 'comment_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class CommentService extends ChopperService {
  @Get(path: "mentorship_relation/{relation_id}/task/{task_id}/comments")
  Future<Response<List<dynamic>>> getAllComments(
    @Path("relation_id") int relationId,
    @Path("task_id") int taskId,
  );

  @Post(path: "mentorship_relation/{relation_id}/task/{task_id}/comment")
  Future<Response<Map<String, dynamic>>> newComment(
    @Path("relation_id") int relationId,
    @Path("task_id") int taskId,
    @Body() CommentRequest commentRequest,
  );

  @Put(path: "mentorship_relation/{relation_id}/task/{task_id}/comment/{comment_id}")
  Future<Response<Map<String, dynamic>>> editComment(
    @Path("relation_id") int relationId,
    @Path("task_id") int taskId,
    @Path("comment_id") int commentId,
    @Body() CommentRequest commentRequest,
  );

  @Delete(path: "mentorship_relation/{relation_id}/task/{task_id}/comment/{comment_id}")
  Future<Response<Map<String, dynamic>>> deleteComment(
    @Path("relation_id") int relationId,
    @Path("task_id") int taskId,
    @Path("comment_id") int commentId,
  );

  static CommentService create() {
    final client = ChopperClient(
        baseUrl: API_URL,
        services: [
          _$CommentService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          AuthInterceptor(),
        ]);

    return _$CommentService(client);
  }
}
