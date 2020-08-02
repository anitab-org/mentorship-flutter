import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/models/home_stats.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';

import './bloc.dart';

class StatsPageBloc extends HydratedBloc<StatsPageEvent, StatsPageState> {
  final UserRepository userRepository;

  StatsPageBloc({this.userRepository})
      : assert(userRepository != null),
        super(StatsPageInitial());
  @override
  StatsPageState fromJson(Map<String, dynamic> json) {
    try {
      final homeStats = HomeStats.fromJson(json);
      return StatsPageSuccess(homeStats);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(StatsPageState state) {
    if (state is StatsPageSuccess) {
      return state.homeStats.toJson();
    }
    return null;
  }

  @override
  Stream<StatsPageState> mapEventToState(StatsPageEvent event) async* {
    if (event is StatsPageShowed) {
      yield* _mapStatsRequested(event);
    } else if (event is StatsPageRefresh) {
      yield* _mapStatsRefreshRequested(event);
    }
  }

  Stream<StatsPageState> _mapStatsRequested(StatsPageEvent event) async* {
    if (event is StatsPageShowed) {
      yield StatsPageLoading();
      try {
        final HomeStats homeStats = await userRepository.getHomeStats();
        yield StatsPageSuccess(homeStats);
      } on Failure catch (failure) {
        Logger.root.severe("StatsPageBloc: Failure catched: $failure.message");
        yield StatsPageFailure(failure.message);
      }
    }
  }

  Stream<StatsPageState> _mapStatsRefreshRequested(StatsPageEvent event) async* {
    if (event is StatsPageRefresh) {
      yield StatsPageLoading();
      try {
        final HomeStats homeStats = await userRepository.getHomeStats();
        yield StatsPageSuccess(homeStats);
      } on Failure catch (failure) {
        Logger.root.severe("StatsPageBloc: Failure catched: $failure.message");
        yield state;
      }
    }
  }
}
