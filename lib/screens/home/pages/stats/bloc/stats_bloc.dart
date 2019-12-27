import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/home_stats.dart';
import 'package:mentorship_client/remote/user_repository.dart';

import './bloc.dart';

class StatsPageBloc extends Bloc<StatsPageEvent, StatsPageState> {
  final UserRepository userRepository;

  StatsPageBloc({this.userRepository}) : assert(userRepository != null);

  @override
  StatsPageState get initialState => StatsPageInitial();

  @override
  Stream<StatsPageState> mapEventToState(StatsPageEvent event) async* {
    if (event is StatsScreenShowed) {
      yield StatsPageLoading();
      try {
        final HomeStats homeStats = await userRepository.getHomeStats();
        yield StatsPageSuccess(homeStats);
      } on Failure catch (failure) {
        yield StatsPageFailure(failure.message);
      } on Exception catch (exception) {
        print(exception);
        yield StatsPageFailure(exception.toString());
      }
    }
  }
}
