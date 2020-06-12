import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

import './bloc.dart';

class SendRequestBloc extends Bloc<SendRequestEvent, SendRequestState> {
  final RelationRepository relationRepository;

  SendRequestBloc({@required this.relationRepository}) : assert(relationRepository != null);

  @override
  SendRequestState get initialState => InitialSendRequestState();

  @override
  Stream<SendRequestState> mapEventToState(SendRequestEvent event) async* {
    if (event is RelationRequestSent) {
      try {
        CustomResponse response = await relationRepository.sendRequest(event.request);
        yield InitialSendRequestState(message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe("SendRequestBloc: ${failure.message}");
        yield InitialSendRequestState(message: failure.message);
      }
    }
    if (event is ResetSnackbarMessage) {
      try {
        yield InitialSendRequestState(message: null);
      } on Failure catch (failure) {
        Logger.root.severe("SendRequestBloc: ${failure.message}");
        yield InitialSendRequestState(message: failure.message);
      }
    }
  }
}
