// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$RelationService extends RelationService {
  _$RelationService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RelationService;

  @override
  Future<Response<List>> getAllRelations() {
    final $url = 'mentorship_relations';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List, List>($request);
  }

  @override
  Future<Response<List>> acceptRelation(int relationId) {
    final $url = 'mentorship_relation/$relationId/accept';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List, List>($request);
  }
}
