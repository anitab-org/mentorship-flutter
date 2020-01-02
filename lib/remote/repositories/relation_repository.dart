import 'dart:io';

import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/requests/relation_requests.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

class RelationRepository {
  static final RelationRepository instance = RelationRepository._internal();

  RelationRepository._internal();

  // TODO Find a clever way to remove all this boilerplate (e.g error handling)!
  // Maybe a generic function checking response and catching errors that accepts
  // service method as argument

  /// Returns all mentorship requests and relations of the current user
  Future<List<Relation>> getAllRelationsAndRequests() async {
    try {
      final response = await ApiManager.instance.relationService.getAllRelations();

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      List<Relation> relations = [];

      for (dynamic relationJson in response.body) {
        relations.add(Relation.fromJson(relationJson));
      }

      return relations;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<CustomResponse> acceptRelation(int relationId) async {
    try {
      final response = await ApiManager.instance.relationService.acceptRelation(relationId);

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      CustomResponse customResponse = CustomResponse.fromJson(response.body);

      return customResponse;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<CustomResponse> rejectRelation(int relationId) async {
    try {
      final response = await ApiManager.instance.relationService.rejectRelationship(relationId);

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }

      CustomResponse customResponse = CustomResponse.fromJson(response.body);

      return customResponse;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<CustomResponse> deleteRelation(int relationId) async {
    try {
      final response = await ApiManager.instance.relationService.deleteRelationship(relationId);

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }

      CustomResponse customResponse = CustomResponse.fromJson(response.body);

      return customResponse;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<CustomResponse> cancelRelation(int relationId) async {
    try {
      final response = await ApiManager.instance.relationService.cancelRelationship(relationId);

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }

      CustomResponse customResponse = CustomResponse.fromJson(response.body);

      return customResponse;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<CustomResponse> sendRequest(RelationRequest relationRequest) async {
    try {
      final response = await ApiManager.instance.relationService.sendRequest(relationRequest);

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }

      CustomResponse customResponse = CustomResponse.fromJson(response.body);

      return customResponse;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<Relation> getCurrentRelation() async {
    try {
      final response = await ApiManager.instance.relationService.getCurrentRelation();

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }

      Relation currentRelation = Relation.fromJson(response.body);
      return currentRelation;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }
}
