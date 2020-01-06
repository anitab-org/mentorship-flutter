import 'package:equatable/equatable.dart';

abstract class RequestDetailEvent extends Equatable {
  const RequestDetailEvent();
}

class RequestAccepted extends RequestDetailEvent {
  final int relationId;

  RequestAccepted(this.relationId);

  @override
  List<Object> get props => [relationId];
}
