import 'package:equatable/equatable.dart';

abstract class RequestDetailState extends Equatable {
  const RequestDetailState();
}

class InitialRequestDetailState extends RequestDetailState {
  final String message;

  InitialRequestDetailState({this.message});

  @override
  List<Object> get props => [message];
}
