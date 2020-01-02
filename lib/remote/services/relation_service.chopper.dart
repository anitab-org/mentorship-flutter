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

  @override
  Future<Response<Map<String, dynamic>>> rejectRelationship(int relationId) {
    final $url = 'mentorship_relation/$relationId/reject';
    final $request = Request('PUT', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> deleteRelationship(int relationId) {
    final $url = 'mentorship_relation/$relationId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> cancelRelationship(int relationId) {
    final $url = 'mentorship_relation/$relationId/cancel';
    final $request = Request('PUT', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> sendRequest(
      RelationRequest relationshipRequest) {
    final $url = 'mentorship_relation/send_request';
    final $body = relationshipRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getCurrentRelation() {
    final $url = 'mentorship_relations/current';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
