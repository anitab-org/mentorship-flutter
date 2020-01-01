import 'package:chopper/chopper.dart';
import 'package:mentorship_client/constants.dart';
import 'package:mentorship_client/remote/auth_interceptor.dart';

part 'relation_service.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class RelationService extends ChopperService {
  /// Returns all mentorship requests and relations of the current user
  @Get(path: "mentorship_relations")
  Future<Response<List<dynamic>>> getAllRelations();

  /// Performs the acceptance of a mentorship request
  @Get(path: "mentorship_relation/{relation_id}/accept")
  Future<Response<List<dynamic>>> acceptRelation(@Path("relation_id") int relationId);

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
