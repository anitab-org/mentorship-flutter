import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';

import './bloc.dart';

class MembersPageBloc extends Bloc<MembersPageEvent, MembersPageState> {
  final UserRepository userRepository;

  MembersPageBloc({this.userRepository}) : assert(userRepository != null);

  @override
  MembersPageState get initialState => MembersPageInitial();

  @override
  Stream<MembersPageState> mapEventToState(MembersPageEvent event) async* {
    if (event is MembersPageShowed) {
      yield MembersPageLoading();
      try {
        final List<User> users = await userRepository.getVerifiedUsers();
        yield MembersPageSuccess(users);
      } on Failure catch (failure) {
        Logger.root.severe(failure.message);
        yield MembersPageFailure(failure.message);
      }
    }
  }
}
