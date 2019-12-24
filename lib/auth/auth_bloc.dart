import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mentorship_client/auth/bloc.dart';
import 'package:mentorship_client/user_repository.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc(this.userRepository);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // TODO Implement full authentication system

    if (event is JustLoggedIn) {
      yield AuthAuthenticated();
    }

    if (event is JustLoggedOut) {
      yield AuthUnauthenticated();
    }
  }
}
