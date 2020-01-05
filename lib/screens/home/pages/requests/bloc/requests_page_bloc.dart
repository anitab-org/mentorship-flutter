import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

import './bloc.dart';

class RequestsPageBloc extends Bloc<RequestsPageEvent, RequestsPageState> {
  final RelationRepository relationRepository;

  RequestsPageBloc({@required this.relationRepository}) : assert(relationRepository != null);

  @override
  RequestsPageState get initialState => RequestsPageLoading();

  @override
  Stream<RequestsPageState> mapEventToState(RequestsPageEvent event) async* {
    if (event is RequestsPageShowed) {
      yield RequestsPageLoading();
      try {
        List<Relation> relations = await relationRepository.getAllRelationsAndRequests();
        yield RequestsPageSuccess(relations);
      } on Failure catch (failure) {
        Logger.root.severe("RequestsPageBloc: ${failure.message}");
        yield RequestsPageFailure(message: failure.message);
      }
    }
  }
}
