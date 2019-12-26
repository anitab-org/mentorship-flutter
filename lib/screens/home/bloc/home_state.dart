import 'package:equatable/equatable.dart';
import 'package:mentorship_client/constants.dart';

abstract class HomeState extends Equatable {
  final String title = "YOU SHOULD NEVER SEE IT";

  HomeState();

  @override
  List<Object> get props => [];
}

class HomePageStats extends HomeState {
  @override
  String get title => STATS_PAGE_TITLE;
}

class HomePageProfile extends HomeState {
  @override
  String get title => PROFILE_PAGE_TITLE;
}

class HomePageRelation extends HomeState {
  @override
  String get title => RELATION_PAGE_TITLE;
}

class HomePageMembers extends HomeState {
  @override
  String get title => MEMBERS_PAGE_TITLE;
}

class HomePageRequests extends HomeState {
  @override
  String get title => REQUESTS_PAGE_TITLE;
}
