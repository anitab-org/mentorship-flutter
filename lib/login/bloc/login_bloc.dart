import 'package:bloc/bloc.dart';
import 'package:mentorship_client/auth_repository.dart';
import 'package:mentorship_client/failure.dart';
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
      try {
        final token = await authRepository.login(event.login);
        yield LoginSuccess();
      } on Failure catch (failure) {
        yield LoginFailure(failure.message);
      } on Exception catch (exception) {
        print(exception);
        yield LoginFailure(exception.toString());
      }
    }
  }
}
