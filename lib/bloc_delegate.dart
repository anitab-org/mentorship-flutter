import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

/// BlocDelegate which logs all BLOC events, errors and transitions.
class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    Logger.root.info(event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    super.onError(cubit, error, stacktrace);
    Logger.root.severe(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Logger.root.info(transition);
  }
}
