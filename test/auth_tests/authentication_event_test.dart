import 'package:mentorship_client/auth/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppStarted', () {
    group('AppStarted', () {
      test('props are []', () {
        expect(AppStarted().props, []);
      });

      test('toString is "AppStarted"', () {
        expect(AppStarted().toString(), 'AppStarted');
      });
    });

    group('JustLoggedIn', () {
      test('props are [token]', () {
        expect(JustLoggedIn('token').props, ['token']);
      });

      test('toString is "LoggedIn { token: token }"', () {
        expect(
          JustLoggedIn('token').toString(),
          'LoggedIn { token: token }',
        );
      });
    });

    group('JustLoggedOut', () {
      test('props are []', () {
        expect(JustLoggedOut().props, []);
      });

      test('toString is "AuthenticationLoggedOut"', () {
        expect(JustLoggedOut().toString(), 'JustLoggedOut');
      });
    });
  });
}
