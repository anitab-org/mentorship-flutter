import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/auth/bloc.dart';
import 'package:mentorship_client/bloc_delegate.dart';
import 'package:mentorship_client/remote/auth_repository.dart';
import 'package:mentorship_client/screens/home/home_screen.dart';
import 'package:mentorship_client/screens/login/login_screen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  _setupLogging();

  runApp(BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(AuthRepository.instance)..add(AppStarted()),
    child: MentorshipApp(),
  ));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MentorshipApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Systers Mentorship',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.lightBlueAccent,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthUninitialized || state is AuthUnauthenticated) {
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
    );
  }
}
