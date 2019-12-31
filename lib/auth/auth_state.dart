import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => null;
}

class AuthUninitialized extends AuthState {}

class AuthAuthenticated extends AuthState {}

/// Represents app state when the user is not signed in.
/// [justLoggedOut] signifies that a logout happened
/// very recently.
class AuthUnauthenticated extends AuthState {
  final bool justLoggedOut;

  AuthUnauthenticated({this.justLoggedOut = false});

  @override
  List<Object> get props => [justLoggedOut];
}

class AuthInProgress extends AuthState {}
