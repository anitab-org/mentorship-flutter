import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:mentorship_client/remote/repositories/auth_repository.dart';
import 'package:mentorship_client/auth/bloc.dart';

class MockUserRepository extends Mock implements AuthRepository {}

void main() {
  AuthBloc authenticationBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = AuthBloc(userRepository);
  });

  tearDown(() {
    authenticationBloc?.close();
  });

  test('initial state is correct', () {
    expect(authenticationBloc.state, AuthUninitialized());
  });

  test('close does not emit new states', () {
    expectLater(
      authenticationBloc,
      emitsInOrder([emitsDone]),
    );
    authenticationBloc.close();
  });

  group('AppStarted', () {
    test('emits [unauthenticated] for invalid token', () {
      final expectedResponse = [
        AuthUnauthenticated(),
      ];

      when(userRepository.getToken()).thenAnswer((_) => Future.value(null));

      expectLater(
        authenticationBloc,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.add(AppStarted());
    });
  });
  group('LoggedIn', () {
    test('emits [loading, authenticated] when token is persisted', () {
      final expectedResponse = [
        AuthInProgress(),
        AuthAuthenticated(),
      ];

      expectLater(
        authenticationBloc,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.add(JustLoggedIn(
        'instance.token',
      ));
    });
  });
  group('LoggedOut', () {
    test('emits [loading, unauthenticated] when token is deleted', () {
      final expectedResponse = [
        AuthInProgress(),
        AuthUnauthenticated(
          justLoggedOut: true,
        ),
      ];

      expectLater(
        authenticationBloc,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.add(JustLoggedOut());
    });
  });
}
