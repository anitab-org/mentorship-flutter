import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeScreenStats();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is StatsPageSelected) {
      yield HomeScreenStats();
    }

    if (event is ProfilePageSelected) {
      yield HomeScreenProfile();
    }

    if (event is RelationPageSelected) {
      yield HomeScreenRelation();
    }

    if (event is MembersPageSelected) {
      yield HomeScreenMembers();
    }

    if (event is RequestsPageSelected) {
      yield HomeScreenRequests();
    }
  }
}
