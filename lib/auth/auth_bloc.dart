import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/auth/bloc.dart';
import 'package:mentorship_client/remote/auth_repository.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository userRepository;

  AuthBloc(this.userRepository);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
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
      yield AuthUnauthenticated();
      await userRepository.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}
