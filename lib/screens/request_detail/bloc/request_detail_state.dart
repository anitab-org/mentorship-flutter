import 'package:equatable/equatable.dart';

abstract class RequestDetailState extends Equatable {
  final String message;

  RequestDetailState({this.message});

  @override
  List<Object> get props => [message];
}

class InitialRequestDetailState extends RequestDetailState {
  InitialRequestDetailState({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}

// Considered = Accepted or Rejected or Deleted
class RequestConsidered extends RequestDetailState {
  RequestConsidered({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
