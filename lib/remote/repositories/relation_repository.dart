import 'dart:io';

import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/relation.dart';

class RelationRepository {
  static final RelationRepository instance = RelationRepository._internal();

  RelationRepository._internal();

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
}
