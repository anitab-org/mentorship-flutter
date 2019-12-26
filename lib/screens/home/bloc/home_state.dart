import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomePageStats extends HomeState {}

class HomePageProfile extends HomeState {}

class HomePageRelation extends HomeState {}

class HomePageMembers extends HomeState {}

class HomePageRequests extends HomeState {}
