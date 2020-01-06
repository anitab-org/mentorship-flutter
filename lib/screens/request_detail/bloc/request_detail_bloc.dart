import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

import './bloc.dart';

class RequestDetailBloc extends Bloc<RequestDetailEvent, RequestDetailState> {
  final RelationRepository relationRepository;

  RequestDetailBloc({@required this.relationRepository}) : assert(relationRepository != null);

  @override
  RequestDetailState get initialState => InitialRequestDetailState();

  @override
  Stream<RequestDetailState> mapEventToState(RequestDetailEvent event) async* {
    if (event is RequestAccepted) {
      try {
        CustomResponse response = await relationRepository.acceptRelation(event.relationId);
        yield RequestConsidered(message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe("RequestsDetailBloc: ${failure.message}");
        yield InitialRequestDetailState(message: failure.message);
      }
    }

    if (event is RequestDeleted) {
      try {
        CustomResponse response = await relationRepository.deleteRelation(event.relationId);
        yield RequestConsidered(message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe("RequestsDetailBloc: ${failure.message}");
        yield InitialRequestDetailState(message: failure.message);
      }
    }

    if (event is RequestRejected) {
      try {
        CustomResponse response = await relationRepository.rejectRelation(event.relationId);
        yield RequestConsidered(message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe("RequestsDetailBloc: ${failure.message}");
        yield InitialRequestDetailState(message: failure.message);
      }
    }
  }
}
