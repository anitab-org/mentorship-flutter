import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';

import './bloc.dart';

class RequestsPageBloc extends HydratedBloc<RequestsPageEvent, RequestsPageState> {
  final RelationRepository relationRepository;

  RequestsPageBloc({@required this.relationRepository})
      : assert(relationRepository != null),
        super(RequestsPageLoading());
  @override
  RequestsPageState fromJson(Map<String, dynamic> json) {
    try {
      List<Relation> relations = Relation.relations(json["relations"]);
      return RequestsPageSuccess(relations);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(RequestsPageState state) {
    if (state is RequestsPageSuccess) {
      return {"relations": state.relations.map((item) => item.toJson()).toList()};
    }
    return null;
  }

  @override
  Stream<RequestsPageState> mapEventToState(RequestsPageEvent event) async* {
    if (event is RequestsPageShowed && state is! RequestsPageSuccess) {
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
        Logger.root.severe("RequestsPageBloc: Failure catched: $failure.message");
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
      } on Failure catch (failure) {
        Logger.root.severe("RequestsPageBloc: Failure catched: $failure.message");
        yield RequestsPageBloc(relationRepository: relationRepository).state;
      }
    }
  }
}
