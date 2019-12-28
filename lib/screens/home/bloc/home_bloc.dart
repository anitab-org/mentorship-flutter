import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomePageStats();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is StatsPageSelected) {
      yield HomePageStats();
    }

    if (event is ProfilePageSelected) {
      yield HomePageProfile();
    }

    if (event is ProfilePageEditClicked) {
      yield HomePageProfileEditing();
    }

    if (event is ProfilePageEditSubmitted) {
      yield HomePageProfile();
    }

    if (event is RelationPageSelected) {
      yield HomePageRelation();
    }

    if (event is MembersPageSelected) {
      yield HomePageMembers();
    }

    if (event is RequestsPageSelected) {
      yield HomePageRequests();
    }
  }
}
