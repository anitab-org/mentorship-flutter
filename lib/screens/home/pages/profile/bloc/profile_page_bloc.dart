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
  final User user; // User object which will receive possible edits

  ProfilePageBloc({this.userRepository, this.user}) : assert(userRepository != null);

  @override
  ProfilePageState get initialState => ProfilePageInitial();

  @override
  Stream<ProfilePageState> mapEventToState(ProfilePageEvent event) async* {
    if (event is ProfilePageShowed) {
      yield ProfilePageLoading();
      try {
        final User user = await userRepository.getCurrentUser();
        Logger.root.warning("GETTING USEEEER");
        yield ProfilePageSuccess(user); // TODO Change to false!
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
      CustomResponse response = await userRepository.updateUser(event.user);
      yield ProfilePageSuccess(event.user);
    }
  }
}
