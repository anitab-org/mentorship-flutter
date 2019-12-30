import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

import './bloc.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final UserRepository userRepository;
  User user; // User object which will receive possible edits

  ProfilePageBloc({this.userRepository, this.user}) : assert(userRepository != null);

  @override
  ProfilePageState get initialState => ProfilePageInitial();

  @override
  Stream<ProfilePageState> mapEventToState(ProfilePageEvent event) async* {
    if (event is ProfilePageShowed) {
      yield ProfilePageLoading();
      try {
        user = await userRepository.getCurrentUser();
        yield ProfilePageSuccess(user);
      } on Failure catch (failure) {
        Logger.root.severe(failure.message);
        yield ProfilePageFailure(failure.message);
      } on Exception catch (exception) {
        Logger.root.severe(exception.toString());
        yield ProfilePageFailure(exception.toString());
      }
    }
    if (event is ProfilePageEditStarted) {
      yield ProfilePageEditing(user);
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

      CustomResponse response = await userRepository.updateUser(updatedUser);
      add(ProfilePageShowed()); // refresh
    }
  }
}
