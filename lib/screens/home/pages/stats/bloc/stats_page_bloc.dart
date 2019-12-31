import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/home_stats.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';

import './bloc.dart';

class StatsPageBloc extends Bloc<StatsPageEvent, StatsPageState> {
  final UserRepository userRepository;

  StatsPageBloc({this.userRepository}) : assert(userRepository != null);

  @override
  StatsPageState get initialState => StatsPageInitial();

  @override
  Stream<StatsPageState> mapEventToState(StatsPageEvent event) async* {
    if (event is StatsPageShowed) {
      yield StatsPageLoading();
      try {
        final HomeStats homeStats = await userRepository.getHomeStats();
        yield StatsPageSuccess(homeStats);
      } on Failure catch (failure) {
        Logger.root.severe(failure.message);
        yield StatsPageFailure(failure.message);
      }
    }
  }
}
