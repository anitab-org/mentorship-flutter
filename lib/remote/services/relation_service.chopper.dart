// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relation_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$RelationService extends RelationService {
  _$RelationService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RelationService;

  @override
  Future<Response<List<dynamic>>> getAllRelations() {
    final $url = 'mentorship_relations';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<dynamic>, List<dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> acceptRelation(int relationId) {
    final $url = 'mentorship_relation/$relationId/accept';
    final $request = Request('PUT', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
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
      RelationRequest relationRequest) {
    final $url = 'mentorship_relation/send_request';
    final $body = relationRequest;
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
