import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/user.dart';

abstract class MembersPageState extends Equatable {
  const MembersPageState();

  @override
  List<Object> get props => [];
}

class MembersPageInitial extends MembersPageState {}

class MembersPageLoading extends MembersPageState {}

class MembersPageSuccess extends MembersPageState {
  final List<User> users;

  MembersPageSuccess(this.users);

  @override
  List<Object> get props => [users];
}

class MembersPageFailure extends MembersPageState {
  final String message;

  MembersPageFailure(this.message);

  @override
  List<Object> get props => [message];
}
