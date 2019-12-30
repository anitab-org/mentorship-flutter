import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/user.dart';

abstract class ProfilePageState extends Equatable {
  final String message; // Optional message to be shown in e.g Snackbar

  ProfilePageState({this.message});

  @override
  List<Object> get props => [message];
}

class ProfilePageInitial extends ProfilePageState {
  ProfilePageInitial({String message}) : super(message: message);
}

class ProfilePageLoading extends ProfilePageState {
  ProfilePageLoading({String message}) : super(message: message);
}

class ProfilePageSuccess extends ProfilePageState {
  final User user;

  ProfilePageSuccess(this.user, {String message}) : super(message: message);

  @override
  List<Object> get props => [message, user];
}

class ProfilePageEditing extends ProfilePageState {
  final User user;

  ProfilePageEditing(this.user, {String message}) : super(message: message);

  @override
  List<Object> get props => [message, user];
}

class ProfilePageFailure extends ProfilePageState {
  ProfilePageFailure({String message}) : super(message: message);
}
