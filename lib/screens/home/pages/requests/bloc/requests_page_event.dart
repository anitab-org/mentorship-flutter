import 'package:equatable/equatable.dart';

abstract class RequestsPageEvent extends Equatable {
  const RequestsPageEvent();
}

class RequestsPageShowed extends RequestsPageEvent {
  @override
  List<Object> get props => null;
}

class RequestsPageRelationAccepted extends RequestsPageEvent {
  final int relationId;

  RequestsPageRelationAccepted(this.relationId);

  @override
  List<Object> get props => [relationId];
}
