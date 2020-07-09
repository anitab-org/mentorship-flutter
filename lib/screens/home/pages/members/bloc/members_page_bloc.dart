import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';

import './bloc.dart';

class MembersPageBloc extends Bloc<MembersPageEvent, MembersPageState> {
  final UserRepository userRepository;
  int pageNumber = 1;
  MembersPageBloc({@required this.userRepository}) : assert(userRepository != null);
  @override
  MembersPageState get initialState => MembersPageInitial();

  @override
  Stream<MembersPageState> mapEventToState(MembersPageEvent event) async* {
    if (event is MembersPageShowed) {
      yield* _mapEventToMembersShowed(event);
    } else if (event is MembersPageRefresh) {
      yield* _mapEventToMembersRefresh(event);
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
        if (currentState is MembersPageSuccess) {
          final users =
              await userRepository.getVerifiedUsers((currentState.users.length ~/ 10) + 1);
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
  }

  Stream<MembersPageState> _mapEventToMembersRefresh(MembersPageEvent event) async* {
    final currentState = state;

    if (event is MembersPageRefresh && !_hasReachedMax(currentState)) {
      try {
        yield MembersPageLoading();
        final List<User> users = await userRepository.getVerifiedUsers(pageNumber);
        yield MembersPageSuccess(users: users, hasReachedMax: false);
      } on Failure catch (failure) {
        Logger.root.severe("MembersPageBloc: Failure catched: $failure.message");
        yield state;
      }
    }
  }
}

bool _hasReachedMax(MembersPageState state) => state is MembersPageSuccess && state.hasReachedMax;
