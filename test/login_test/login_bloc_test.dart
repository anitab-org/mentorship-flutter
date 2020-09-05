import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/requests/login.dart';
import 'package:mentorship_client/remote/responses/auth_token.dart';
import 'package:mentorship_client/screens/login/bloc/bloc.dart';

import 'package:mockito/mockito.dart';
import 'package:mentorship_client/remote/repositories/auth_repository.dart';
import 'package:mentorship_client/auth/bloc.dart';

class MockUserRepository extends Mock implements AuthRepository {}

class MockAuthenticationBloc extends Mock implements AuthBloc {}

void main() {
  LoginBloc loginBloc;

  MockUserRepository userRepository;
  MockAuthenticationBloc authenticationBloc;
  Login login;
  AuthToken authToken;
  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = MockAuthenticationBloc();
    loginBloc = LoginBloc(
      userRepository,
      authenticationBloc,
    );
    login = Login(
      username: 'valid.username',
      password: 'valid.password',
    );

    authToken = AuthToken(
      'valid.token',
      7,
    );
  });

  tearDown(() {
    loginBloc?.close();
    authenticationBloc?.close();
  });

  test('initial state is correct', () {
    expect(loginBloc.state, LoginInitial());
  });

  test('close does not emit new states', () {
    expectLater(
      loginBloc,
      emitsInOrder([emitsDone]),
    );
    loginBloc.close();
  });

  group('LoginButtonPressed', () {
    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginSuccess] and token on success',
      build: () {
        when(userRepository.login(
          login,
        )).thenAnswer((_) => Future.value(
              authToken,
            ));
        return loginBloc;
      },
      act: (bloc) => bloc.add(
        LoginButtonPressed(
          login,
        ),
      ),
      expect: [
        LoginInProgress(),
        LoginSuccess(),
      ],
      verify: (_) async {
        verify(authenticationBloc.add(JustLoggedIn(
          authToken.token,
        ))).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] on failure',
      build: () {
        when(userRepository.login(
          login,
        )).thenThrow(Failure('login-error'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(
        LoginButtonPressed(login),
      ),
      expect: [
        LoginInProgress(),
        LoginFailure('login-error'),
      ],
      verify: (_) async {
        verifyNever(authenticationBloc.add(any));
      },
    );
  });
}
