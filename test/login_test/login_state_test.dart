import 'package:flutter_test/flutter_test.dart';
import 'package:mentorship_client/screens/login/bloc/bloc.dart';

void main() {
  group('LoginState', () {
    group('LoginInitial', () {
      test('toString is LoginInitial', () {
        expect(LoginInitial().toString(), 'LoginInitial');
      });
    });

    group('LoginInProgress', () {
      test('toString is LoginLoading', () {
        expect(LoginInProgress().toString(), 'LoginInProgress');
      });
    });

    group('LoginFailure', () {
      test('props are [error]', () {
        expect(LoginFailure('message').props, ['message']);
      });

      test('toString is LoginFailure { error: message }', () {
        expect(
          LoginFailure('message').toString(),
          'LoginFailure { error: message }',
        );
      });
    });
  });
}
