import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/models/task.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/repositories/task_repository.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

import 'bloc.dart';

class RelationPageBloc extends HydratedBloc<RelationPageEvent, RelationPageState> {
  final RelationRepository relationRepository;
  final TaskRepository taskRepository;

  RelationPageBloc({@required this.relationRepository, @required this.taskRepository})
      : assert(relationRepository != null),
        assert(taskRepository != null),
        super(RelationPageLoading());
  @override
  RelationPageState fromJson(Map<String, dynamic> json) {
    try {
      Relation relation = Relation.fromJson(json["relation"]);
      List<Task> tasks = Task.tasks(json["tasks"]);
      return RelationPageSuccess(relation, tasks);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(RelationPageState state) {
    if (state is RelationPageSuccess) {
      print("====================");
      print(state.tasks.map((item) => item.toJson()));
      print(state.relation.toJson());
      return {
        "relation": state.relation.toJson(),
        "tasks": state.tasks.map((item) => item.toJson()).toList()
      };
    }
    return null;
  }

  @override
  Stream<RelationPageState> mapEventToState(RelationPageEvent event) async* {
    if (event is RelationPageShowed && state is! RelationPageSuccess) {
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
    if (event is RelationPageRefresh) {
      yield RelationPageLoading();
      try {
        Relation relation = await relationRepository.getCurrentRelation();
        List<Task> tasks;
        if (relation != null) {
          tasks = await taskRepository.getAllTasks(relation.id);
        }
        yield RelationPageSuccess(relation, tasks);
      } on Failure catch (failure) {
        Logger.root.severe("RelationPageBloc: Failure catched: $failure.message");
        yield RelationPageBloc(
                relationRepository: relationRepository, taskRepository: taskRepository)
            .state;
      }
    }

    if (event is RelationPageCancelledRelation) {
      yield RelationPageLoading();
      try {
        CustomResponse response = await relationRepository.cancelRelation(event.relationId);
        yield RelationPageFailure(
            message: response
                .message); // Failure, because relation doesn't exist anymore. It's kinda dirty but works
      } on Failure catch (failure) {
        Logger.root.severe("RelationPageBloc: Failure catched: $failure.message");
        yield RelationPageFailure(message: failure.message);
      }
    }

    if (event is TaskCreated) {
      try {
        CustomResponse response =
            await taskRepository.createTask(event.relation.id, event.taskRequest);
        var tasks = await taskRepository.getAllTasks(event.relation.id);
        yield RelationPageSuccess(event.relation, tasks, message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe("RelationPageBloc: Failure catched: $failure.message");
        yield RelationPageFailure(message: failure.message);
      }
    }

    if (event is TaskCompleted) {
      try {
        CustomResponse response =
            await taskRepository.completeTask(event.relation.id, event.taskId);
        var tasks = await taskRepository.getAllTasks(event.relation.id);
        yield RelationPageSuccess(event.relation, tasks, message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe("RelationPageBloc: Failure catched: $failure.message");
        yield RelationPageFailure(message: failure.message);
      }
    }

    if (event is TaskDeleted) {
      try {
        CustomResponse response = await taskRepository.deleteTask(event.relation.id, event.taskId);
        var tasks = await taskRepository.getAllTasks(event.relation.id);
        yield RelationPageSuccess(event.relation, tasks, message: response.message);
      } on Failure catch (failure) {
        Logger.root.severe("RelationPageBloc: Failure catched: $failure.message");
        yield RelationPageFailure(message: failure.message);
      }
    }
  }
}
