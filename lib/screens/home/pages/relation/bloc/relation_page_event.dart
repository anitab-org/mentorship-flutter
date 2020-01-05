import 'package:equatable/equatable.dart';

abstract class RelationPageEvent extends Equatable {
  const RelationPageEvent();
}

class RelationPageShowed extends RelationPageEvent {
  @override
  List<Object> get props => null;
}
