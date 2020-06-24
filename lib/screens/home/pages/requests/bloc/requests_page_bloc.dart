import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';

import './bloc.dart';

class RequestsPageBloc extends Bloc<RequestsPageEvent, RequestsPageState> {
  final RelationRepository relationRepository;

  RequestsPageBloc({@required this.relationRepository}) : assert(relationRepository != null);

  @override
  RequestsPageState get initialState => RequestsPageLoading();

  @override
  Stream<RequestsPageState> mapEventToState(RequestsPageEvent event) async* {
    if (event is RequestsPageShowed) {
      yield* _mapEventToRequestsShowed(event);
    } else if (event is RequestsPageRefresh) {
      yield* _mapEventToRequestsRefresh(event);
    }
  }

  Stream<RequestsPageState> _mapEventToRequestsShowed(RequestsPageEvent event) async* {
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

  Stream<RequestsPageState> _mapEventToRequestsRefresh(RequestsPageEvent event) async* {
    if (event is RequestsPageRefresh) {
      yield RequestsPageLoading();
      try {
        List<Relation> relations = await relationRepository.getAllRelationsAndRequests();
        yield RequestsPageSuccess(relations);
      } on Failure catch (_) {
        yield state;
      }
    }
  }
}
