import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class StatsPageSelected extends HomeEvent {}

class ProfilePageSelected extends HomeEvent {}

// Dirty but I don't have other idea
class ProfilePageEditStarted extends HomeEvent {}

// Dirty too
class ProfilePageEditSubmitted extends HomeEvent {}

class RelationPageSelected extends HomeEvent {}

class MembersPageSelected extends HomeEvent {}

class RequestsPageSelected extends HomeEvent {}
