import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/user.dart';

abstract class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object> get props => null;
}

class ProfilePageShowed extends ProfilePageEvent {
  final String message;

  ProfilePageShowed({this.message});
}

class ProfilePageRefresh extends ProfilePageEvent {
  final String message;

  ProfilePageRefresh({this.message});
}

class ProfilePageEditStarted extends ProfilePageEvent {}

class ProfilePageEditSubmitted extends ProfilePageEvent {
  final User user;

  ProfilePageEditSubmitted(this.user);

  @override
  List<Object> get props => [user];
}

class ProfilePageEditCancelled extends ProfilePageEvent {}
