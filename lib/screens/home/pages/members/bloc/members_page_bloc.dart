import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';

import './bloc.dart';

class MembersPageBloc extends HydratedBloc<MembersPageEvent, MembersPageState> {
  final UserRepository userRepository;
  int pageNumber = 1;
  MembersPageBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(MembersPageInitial());
  @override
  MembersPageState fromJson(Map<String, dynamic> json) {
    try {
      List<User> users = User.users(json["users"]);
      bool hasReachedMax = json["hasReachedMax"];
      return MembersPageSuccess(users: users, hasReachedMax: hasReachedMax);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(MembersPageState state) {
    if (state is MembersPageSuccess) {
      return {
        "users": state.users.map((item) => item.toJson()).toList(),
        "hasReachedMax": state.hasReachedMax
      };
    }
    return null;
  }

  @override
  Stream<MembersPageState> mapEventToState(MembersPageEvent event) async* {
    if (event is MembersPageShowed && state is! MembersPageSuccess) {
      yield* _mapEventToMembersShowed(event);
    } else if (event is MembersPageRefresh) {
      yield* _mapEventToMembersRefresh(event);
    } else if (event is MoreMembers) {
      yield* _mapEventToMembersSuccess(event);
    }
  }

  Stream<MembersPageState> _mapEventToMembersShowed(MembersPageEvent event) async* {
    final currentState = state;

    if (event is MembersPageShowed && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MembersPageInitial) {
          yield MembersPageLoading();
          final List<User> users = await userRepository.getVerifiedUsers(pageNumber);
          yield MembersPageSuccess(users: users, hasReachedMax: false);
        }
      } on Failure catch (failure) {
        Logger.root.severe("MembersPageBloc: Failure catched: $failure.message");
        yield MembersPageFailure(failure.message);
      }
    }
  }

<<<<<<< HEAD
  Stream<MembersPageState> _mapEventToMembersSuccess(MembersPageEvent event) async* {
    final currentState = state;
    try {
      if (currentState is MembersPageSuccess) {
        final users = await userRepository.getVerifiedUsers((currentState.users.length ~/ 10) + 1);
        yield users.isEmpty
            ? currentState.copyWith(hasReachedMax: true)
            : MembersPageSuccess(
                users: currentState.users + users,
                hasReachedMax: false,
              );
      }
    } on Failure catch (failure) {
      Logger.root.severe("MembersPageBloc: Failure catched: $failure.message");
      yield MembersPageFailure(failure.message);
    }
  }
=======
  Stream<MembersPageState> _mapEventToMembersRefresh(MembersPageEvent event) async* {
>>>>>>> a4d58f2b9eb7cd440728fcfa97cca4eff99d345d

  Stream<MembersPageState> _mapEventToMembersRefresh(MembersPageEvent event) async* {
    if (event is MembersPageRefresh && state is MembersPageSuccess) {
      try {
        yield MembersPageLoading();
        final List<User> users = await userRepository.getVerifiedUsers(pageNumber);
        yield MembersPageSuccess(users: users, hasReachedMax: false);
      } on Failure catch (failure) {
        Logger.root.severe("MembersPageBloc: Failure catched: $failure.message");
        yield MembersPageBloc(userRepository: userRepository).state;
      }
    }
  }
}

bool _hasReachedMax(MembersPageState state) => state is MembersPageSuccess && state.hasReachedMax;
