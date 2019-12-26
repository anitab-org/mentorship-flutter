import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/auth/auth_event.dart';
import 'package:mentorship_client/screens/home/bloc/bloc.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.title),
          ),
          body: Center(
            child: RaisedButton(
              child: Text("Log out"),
              onPressed: () {
                Toast.show("Logged out!", context);
                BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profile")),
              BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("Relation")),
              BottomNavigationBarItem(icon: Icon(Icons.people_outline), title: Text("Members")),
              BottomNavigationBarItem(icon: Icon(Icons.comment), title: Text("Requests"))
            ],
          ),
        );
      }),
    );
  }
}
