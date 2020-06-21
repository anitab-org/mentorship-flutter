import 'package:flutter_test/flutter_test.dart';
import 'package:mentorship_client/remote/requests/login.dart';
import 'package:mentorship_client/screens/login/bloc/bloc.dart';


void main() {
  Login login;
  setUp(() {
    login = Login(
      username: 'valid.username',
      password: 'valid.password',
    );
  });
  group('LoginEvent', () {
    group('LoginButtonPressed', () {
      test('props are [username, password]', () {
        expect(
          LoginButtonPressed(
            login,
          ).props,
          [
            login,
          ],
        );
      });
    });
  });
}
