import 'package:bloc/bloc.dart';
import 'package:mentorship_client/login/bloc/login_event.dart';
import 'package:mentorship_client/login/bloc/login_state.dart';
import 'package:mentorship_client/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  // final AuthBloc authBloc;

  LoginBloc(this.userRepository);

  @override
  get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
    }
    yield LoginInProgress();
  }
}

class AuthenticationRepository {}
