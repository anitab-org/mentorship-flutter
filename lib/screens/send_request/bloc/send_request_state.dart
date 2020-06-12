import 'package:equatable/equatable.dart';

abstract class SendRequestState extends Equatable {
  final String message;

  SendRequestState({this.message});

  @override
  List<Object> get props => [message];
}

class InitialSendRequestState extends SendRequestState {
  InitialSendRequestState({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
