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
      yield MembersPageLoading();
      // if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MembersPageInitial) {
          final List<User> users = await userRepository.getVerifiedUsers(pageNumber);
          yield MembersPageSuccess(users: users, hasReachedMax: false);
          print(currentState);
        }
        if (currentState is MembersPageSuccess) {
          print("bloc number");
          print(currentState.users.length ~/ 10);
          final users = await userRepository.getVerifiedUsers(currentState.users.length ~/ 10);
          yield users.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : MembersPageSuccess(
                  users: currentState.users + users,
                  hasReachedMax: false,
                );
        }
        print(currentState);
        // final List<User> users = await userRepository.getVerifiedUsers(pageNumber);
        // yield MembersPageSuccess(users);
      } on Failure catch (failure) {
        Logger.root.severe(failure.message);
        yield MembersPageFailure(failure.message);
      }
    }
  }
}

bool _hasReachedMax(MembersPageState state) => state is MembersPageSuccess && state.hasReachedMax;
