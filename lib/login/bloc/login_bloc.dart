import 'package:bloc/bloc.dart';
import 'package:mentorship_client/auth_repository.dart';
import 'package:mentorship_client/login/bloc/login_event.dart';
import 'package:mentorship_client/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  // final AuthBloc authBloc;

  LoginBloc(this.authRepository);

  @override
  get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();
      var token = authRepository.login(event.login); // TODO Catch errors!
      print(token);
    }
    yield LoginInProgress();
  }
}

class AuthenticationRepository {}
