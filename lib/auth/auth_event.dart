import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class JustLoggedIn extends AuthEvent {
  final String token;

  const JustLoggedIn(this.token);

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class JustLoggedOut extends AuthEvent {}
