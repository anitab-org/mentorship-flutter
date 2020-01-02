import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/requests/relation_requests.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

typedef ApiFunction<T> = Future<Response<T>> Function();

class RelationRepository {
  static final RelationRepository instance = RelationRepository._internal();

  RelationRepository._internal();

  /// Generic method which handles all possible exceptions that might
  /// happen when calling API
  Future<T> callSafely<T>(ApiFunction apiFunction) async {
    try {
      final response = await apiFunction();

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      return response.body;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  /// Returns all mentorship requests and relations of the current user
  Future<List<Relation>> getAllRelationsAndRequests() async {
    final body = await callSafely(() async =>
    await ApiManager.instance.relationService.getAllRelations());

    List<Relation> relations = [];
    for (var relation in body) {
      relations.add(Relation.fromJson(relation));
    }

    return relations;
  }

  Future<CustomResponse> acceptRelation(int relationId) async {
    final body = await callSafely(() async =>
    await ApiManager.instance.relationService.acceptRelation(relationId));

    return CustomResponse.fromJson(body);
  }

  Future<CustomResponse> rejectRelation(int relationId) async {
    final body = await callSafely(() async =>
    await ApiManager.instance.relationService.rejectRelationship(relationId));

    return CustomResponse.fromJson(body);
  }

  Future<CustomResponse> deleteRelation(int relationId) async {
    final body = await callSafely(() async =>
    await ApiManager.instance.relationService.deleteRelationship(relationId));

    return CustomResponse.fromJson(body);
  }

  Future<CustomResponse> cancelRelation(int relationId) async {
    final body = await callSafely(() async =>
    await ApiManager.instance.relationService.cancelRelationship(relationId));

    return CustomResponse.fromJson(body);
  }

  Future<CustomResponse> sendRequest(RelationRequest relationRequest) async {
    final body = await callSafely(() async =>
    await ApiManager.instance.relationService.sendRequest(relationRequest));

    return CustomResponse.fromJson(body);
  }

  Future<Relation> getCurrentRelation() async {
    final body = await callSafely(() async =>
    await ApiManager.instance.relationService.getCurrentRelation());

    return Relation.fromJson(body);
  }
}