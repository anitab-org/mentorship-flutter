import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

import './bloc.dart';

class ProfilePageBloc extends HydratedBloc<ProfilePageEvent, ProfilePageState> {
  final UserRepository userRepository;
  User _user; // User object which will receive possible edits

  ProfilePageBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(ProfilePageInitial());
  @override
  ProfilePageState fromJson(Map<String, dynamic> json) {
    try {
      final _user = User.fromJson(json);
      return ProfilePageSuccess(_user);
    } catch (e) {   
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(ProfilePageState state) {
    if (state is ProfilePageSuccess) {
      return state.user.toJson();
    }
    return null;
  }

  @override
  Stream<ProfilePageState> mapEventToState(ProfilePageEvent event) async* {
    if (event is ProfilePageShowed && state is! ProfilePageSuccess) {
      yield* mapEventToProfileShowed(event);
    } else if (event is ProfilePageRefresh) {
      yield* mapEventToRefreshRequested(event);
    } else {
      yield* mapEventToProfileEditing(event);
    }
  }

  Stream<ProfilePageState> mapEventToProfileShowed(ProfilePageEvent event) async* {
    if (event is ProfilePageShowed) {
      yield ProfilePageLoading();
      try {
        _user = await userRepository.getCurrentUser();
        yield ProfilePageSuccess(_user, message: event.message);
      } on Failure catch (failure) {
        Logger.root.severe("ProfilePageBloc: Failure catched: $failure.message");
        yield ProfilePageFailure(message: failure.message);
      }
    }
  }

  Stream<ProfilePageState> mapEventToRefreshRequested(ProfilePageEvent event) async* {
    if (event is ProfilePageRefresh) {
      yield ProfilePageLoading();
      try {
        _user = await userRepository.getCurrentUser();
        yield ProfilePageSuccess(_user, message: event.message);
      } on Failure catch (failure) {
        Logger.root.severe("ProfilePageBloc: Failure catched: $failure.message");
        yield ProfilePageBloc(userRepository: userRepository).state;
      }
    }
  }

  Stream<ProfilePageState> mapEventToProfileEditing(ProfilePageEvent event) async* {
    if (event is ProfilePageEditStarted) {
      yield ProfilePageEditing(_user);
    }

    if (event is ProfilePageEditSubmitted) {
      User updatedUser = User(
        id: event.user.id,
        name: event.user.name,
        slackUsername: event.user.slackUsername,
        bio: event.user.bio,
        location: event.user.location,
        occupation: event.user.occupation,
        organization: event.user.organization,
        interests: event.user.interests,
        skills: event.user.skills,
        needsMentoring: event.user.needsMentoring,
        availableToMentor: event.user.availableToMentor,
      );

      try {
        CustomResponse response = await userRepository.updateUser(updatedUser);
        add(ProfilePageShowed(message: response.message));
      } on Failure catch (failure) {
        Logger.root.severe("ProfilePageBloc: Failure catched: $failure.message");
        add(ProfilePageShowed(message: failure.message));
      }
    }
  }
}
