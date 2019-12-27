import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/auth/bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          _buildItem("About", Icons.info),
          _buildItem("Feedback", Icons.feedback),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Log out"),
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());

              Navigator.of(context).pop();
            },
          ),
          _buildItem("Change password", Icons.lock),
          _buildItem("Delete my account", Icons.delete),
        ],
      ),
    );
  }

  Widget _buildItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
