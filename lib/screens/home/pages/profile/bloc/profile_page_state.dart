import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/user.dart';

abstract class ProfilePageState extends Equatable {
  const ProfilePageState();

  @override
  List<Object> get props => [];
}

class ProfilePageInitial extends ProfilePageState {}

class ProfilePageLoading extends ProfilePageState {}

class ProfilePageSuccess extends ProfilePageState {
  final User user;
  final bool editing;

  ProfilePageSuccess(this.user, this.editing);

  @override
  List<Object> get props => [user];
}

class ProfilePageFailure extends ProfilePageState {
  final String message;

  ProfilePageFailure(this.message);

  @override
  List<Object> get props => [message];
}
