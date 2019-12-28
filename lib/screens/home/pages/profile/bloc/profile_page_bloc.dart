import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';

import './bloc.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final UserRepository userRepository;

  ProfilePageBloc({this.userRepository}) : assert(userRepository != null);

  @override
  ProfilePageState get initialState => ProfilePageInitial();

  @override
  Stream<ProfilePageState> mapEventToState(ProfilePageEvent event) async* {
    if (event is ProfilePageShowed) {
      yield ProfilePageLoading();
      try {
        final User user = await userRepository.getCurrentUser();
        yield ProfilePageSuccess(user, false);
      } on Failure catch (failure) {
        Logger.root.severe(failure.message);
        yield ProfilePageFailure(failure.message);
      } on Exception catch (exception) {
        Logger.root.severe(exception.toString());
        yield ProfilePageFailure(exception.toString());
      }
    }
    if (event is ProfilePageEditClicked) {
      final ProfilePageState last = await this.last;

      if (last is ProfilePageSuccess) {
        yield ProfilePageSuccess(last.user, false);
      }
    }
  }
}
