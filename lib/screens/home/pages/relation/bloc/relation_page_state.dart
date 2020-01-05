import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/models/task.dart';

abstract class RelationPageState extends Equatable {
  final String message;

  const RelationPageState({this.message});

  @override
  List<Object> get props => [message];
}

class RelationPageLoading extends RelationPageState {
  RelationPageLoading({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class RelationPageSuccess extends RelationPageState {
  final Relation relation;
  final List<Task> tasks;

  RelationPageSuccess(this.relation, this.tasks, {String message}) : super(message: message);

  @override
  List<Object> get props => [message, relation, tasks];
}

class RelationPageFailure extends RelationPageState {
  RelationPageFailure({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
