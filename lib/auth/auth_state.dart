import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => null;
}

class AuthUninitialized extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {
  final bool justLoggedOut;

  AuthUnauthenticated({this.justLoggedOut = false});

  @override
  List<Object> get props => [justLoggedOut];
}

class AuthInProgress extends AuthState {}
