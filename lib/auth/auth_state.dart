import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_state.g.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => null;
}

class AuthUninitialized extends AuthState {}

@JsonSerializable()
class AuthAuthenticated extends AuthState {
  AuthAuthenticated();
  factory AuthAuthenticated.fromJson(Map<String, dynamic> json) =>
      _$AuthAuthenticatedFromJson(json);
  Map<String, dynamic> toJson() => _$AuthAuthenticatedToJson(this);
}

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
