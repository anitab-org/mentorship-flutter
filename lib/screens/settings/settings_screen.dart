import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/auth/bloc.dart';
import 'package:package_info/package_info.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Info"),
            onTap: () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();

              showAboutDialog(
                context: context,
                applicationIcon: Image.asset(
                  "assets/images/mentorship_system_logo.png",
                  width: 50,
                  height: 50,
                ),
                applicationName: "Mentorship App",
                applicationVersion:
                    "version ${packageInfo.version}, build ${packageInfo.buildNumber}",
                applicationLegalese:
                    "Client app for Mentorship System. Cross-platform version initially created by Bartek Pacia.",
              );
            },
          ),
          _buildItem("Feedback", Icons.feedback),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Log out"),
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());

              Navigator.of(context).pop();
            },
          ),
          _buildItem("Change password", Icons.lock_outline),
          _buildItem("Delete my account", Icons.delete_outline),
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
