import 'package:equatable/equatable.dart';

abstract class RelationPageEvent extends Equatable {
  const RelationPageEvent();
}

class RelationPageShowed extends RelationPageEvent {
  @override
  List<Object> get props => null;
}

class RelationPageCancelledRelation extends RelationPageEvent {
  final int relationId;

  RelationPageCancelledRelation(this.relationId);

  @override
  List<Object> get props => [relationId];
}
