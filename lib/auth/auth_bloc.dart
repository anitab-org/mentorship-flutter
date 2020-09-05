import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mentorship_client/auth/bloc.dart';
import 'package:mentorship_client/remote/repositories/auth_repository.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository userRepository;

  AuthBloc(this.userRepository) : super(AuthUninitialized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final String token = await userRepository.getToken();

      if (token != null) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is JustLoggedIn) {
      yield AuthInProgress();
      await userRepository.persistToken(event.token);
      yield AuthAuthenticated();
    }

    if (event is JustLoggedOut) {
      yield AuthInProgress();
      await userRepository.deleteToken();
      yield AuthUnauthenticated(justLoggedOut: true);
    }
  }
}
