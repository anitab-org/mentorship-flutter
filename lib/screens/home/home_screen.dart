import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/auth/auth_event.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Log out"),
          onPressed: () => BlocProvider.of<AuthBloc>(context).add(JustLoggedOut()),
        ),
      ),
    );
  }
}
