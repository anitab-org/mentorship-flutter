import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/requests/login.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final Login login;

  const LoginButtonPressed(this.login);

  @override
  List<Object> get props => [login];
}

class GoogleSignInButtonPressed extends LoginEvent{


  const GoogleSignInButtonPressed();

  @override
  List<Object> get props => [];
}

class GoogleSignInFailed extends LoginEvent{
  final String message;

  const GoogleSignInFailed(this.message);

  @override
  List<Object> get props => [message];
}
