import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/requests/task_request.dart';

abstract class RelationPageEvent extends Equatable {
  const RelationPageEvent();
}

class RelationPageShowed extends RelationPageEvent {
  @override
  List<Object> get props => null;
}

class RelationPageRefresh extends RelationPageEvent {
  @override
  List<Object> get props => null;
}

class RelationPageCancelledRelation extends RelationPageEvent {
  final int relationId;

  RelationPageCancelledRelation(this.relationId);

  @override
  List<Object> get props => [relationId];
}

class TaskCreated extends RelationPageEvent {
  final Relation relation;
  final TaskRequest taskRequest;

  TaskCreated(this.relation, this.taskRequest);

  @override
  List<Object> get props => [relation, taskRequest];
}

class TaskCompleted extends RelationPageEvent {
  final Relation relation;
  final int taskId;

  TaskCompleted(this.relation, this.taskId);

  @override
  List<Object> get props => [relation, taskId];
}

class TaskDeleted extends RelationPageEvent {
  final Relation relation;
  final int taskId;

  TaskDeleted(this.relation, this.taskId);

  @override
  List<Object> get props => [relation, taskId];
}
