import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/auth/bloc.dart';
import 'package:mentorship_client/bloc_delegate.dart';
import 'package:mentorship_client/remote/repositories/auth_repository.dart';
import 'package:mentorship_client/screens/home/home_screen.dart';
import 'package:mentorship_client/screens/login/login_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

void main() async {
  // Logs all BLoC transitions
  Bloc.observer = SimpleBlocDelegate();
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  // Providing app-wide auth bloc, so that app state changes immediately when
  // auth state changes.
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(AuthRepository.instance),
      child: MentorshipApp(),
    ),
  );
}

/// Adds log level and time to logs printed using [Logger.root]
void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MentorshipApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          if (state.justLoggedOut) {
            Toast.show("Logged out", context, duration: 1);
          }
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Systers Mentorship',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.lightBlueAccent,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthUninitialized) {
              return LoginScreen();
            }
            if (state is AuthUnauthenticated) {
              return LoginScreen();
            }
            if (state is AuthAuthenticated) {
              return HomeScreen();
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
      ),
    );
  }
}
