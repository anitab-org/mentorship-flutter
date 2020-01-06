import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RequestDetailEvent extends Equatable {
  final int relationId;

  const RequestDetailEvent({@required this.relationId});

  @override
  List<Object> get props => [relationId];
}

class RequestAccepted extends RequestDetailEvent {
  RequestAccepted({@required int relationId}) : super(relationId: relationId);
}

class RequestDeleted extends RequestDetailEvent {
  RequestDeleted({@required int relationId}) : super(relationId: relationId);
}

class RequestRejected extends RequestDetailEvent {
  RequestRejected({@required int relationId}) : super(relationId: relationId);
}
