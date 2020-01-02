import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';
import 'package:mentorship_client/remote/auth_interceptor.dart';
import 'package:mentorship_client/remote/requests/relation_requests.dart';

part 'relation_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class RelationService extends ChopperService {
  /// Returns all mentorship requests and relations of the current user
  @Get(path: "mentorship_relations")
  Future<Response<List<dynamic>>> getAllRelations();

  /// Performs the acceptance of a mentorship request
  @Get(path: "mentorship_relation/{relation_id}/accept")
  Future<Response<List<dynamic>>> acceptRelation(@Path("relation_id") int relationId);

  @Put(path: "mentorship_relation/{relation_id}/reject")
  Future<Response<Map<String, dynamic>>> rejectRelationship(@Path("relation_id") int relationId);

  @Delete(path: "mentorship_relation/{relation_id}")
  Future<Response<Map<String, dynamic>>> deleteRelationship(@Path("relation_id") int relationId);

  @Put(path: "mentorship_relation/{relation_id}/cancel")
  Future<Response<Map<String, dynamic>>> cancelRelationship(@Path("relation_id") int relationId);

  @Post(path: "mentorship_relation/send_request")
  Future<Response<Map<String, dynamic>>> sendRequest(@Body() RelationRequest relationshipRequest);

  @Get(path: "mentorship_relations/current")
  Future<Response<Map<String, dynamic>>> getCurrentRelation();

  static RelationService create() {
    final client = ChopperClient(
        baseUrl: API_URL,
        services: [
          _$RelationService(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          AuthInterceptor(),
        ]);

    return _$RelationService(client);
  }
}
