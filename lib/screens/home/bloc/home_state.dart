import 'package:equatable/equatable.dart';
import 'package:mentorship_client/constants.dart';

abstract class HomeState extends Equatable {
  final String title = "YOU SHOULD NEVER SEE IT";
  final int index = -1;

  HomeState();

  @override
  List<Object> get props => [];
}

class HomePageStats extends HomeState {
  @override
  String get title => STATS_PAGE_TITLE;

  @override
  int get index => 0;
}

class HomePageProfile extends HomeState {
  @override
  String get title => PROFILE_PAGE_TITLE;

  @override
  int get index => 1;
}

class HomePageRelation extends HomeState {
  @override
  String get title => RELATION_PAGE_TITLE;

  @override
  int get index => 2;
}

class HomePageMembers extends HomeState {
  @override
  String get title => MEMBERS_PAGE_TITLE;

  @override
  int get index => 3;
}

class HomePageRequests extends HomeState {
  @override
  String get title => REQUESTS_PAGE_TITLE;

  @override
  int get index => 4;
}
