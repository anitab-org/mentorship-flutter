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
  //TODO: debounce the Events in order to prevent spamming our API
  @override
  MembersPageState get initialState => MembersPageInitial();

  @override
  Stream<MembersPageState> mapEventToState(MembersPageEvent event) async* {
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
        Logger.root.severe(failure.message);
        yield MembersPageFailure(failure.message);
      }
    }
  }
}

bool _hasReachedMax(MembersPageState state) => state is MembersPageSuccess && state.hasReachedMax;
