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
  final bool hasReachedMax;

  MembersPageSuccess({
    this.users,
    this.hasReachedMax,
  });

  // We implemented copyWith so that we can copy an instance of MembersPageSuccess
  // and update zero or more properties conveniently.
  MembersPageSuccess copyWith({
    List<User> users,
    bool hasReachedMax,
  }) {
    return MembersPageSuccess(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [users, hasReachedMax];
  @override
  String toString() =>
      'MembersPageSuccess { users: ${users.length}, hasReachedMax: $hasReachedMax }';
}

class MembersPageFailure extends MembersPageState {
  final String message;

  MembersPageFailure(this.message);

  @override
  List<Object> get props => [message];
}
