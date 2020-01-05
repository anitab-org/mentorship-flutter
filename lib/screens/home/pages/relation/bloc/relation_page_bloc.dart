import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/models/task.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/repositories/task_repository.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

import 'bloc.dart';

class RelationPageBloc extends Bloc<RelationPageEvent, RelationPageState> {
  final RelationRepository relationRepository;
  final TaskRepository taskRepository;

  RelationPageBloc({@required this.relationRepository, @required this.taskRepository})
      : assert(relationRepository != null),
        assert(taskRepository != null);

  @override
  RelationPageState get initialState => RelationPageLoading();

  @override
  Stream<RelationPageState> mapEventToState(RelationPageEvent event) async* {
    if (event is RelationPageShowed) {
      yield RelationPageLoading();
      try {
        Relation relation = await relationRepository.getCurrentRelation();
        List<Task> tasks;
        if (relation != null) {
          tasks = await taskRepository.getAllTasks(relation.id);
        }
        yield RelationPageSuccess(relation, tasks);
      } on Failure catch (failure) {
        Logger.root.severe("RelationPageBloc: ${failure.message}");
        yield RelationPageFailure(message: failure.message);
      }
    }

    if (event is RelationPageCancelledRelation) {
      yield RelationPageLoading();
      try {
        CustomResponse response = await relationRepository.cancelRelation(event.relationId);
        yield RelationPageSuccess(null, null, message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe(failure.message);
        yield RelationPageFailure(message: failure.message);
      }
    }
  }
}
