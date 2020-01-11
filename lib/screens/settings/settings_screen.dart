import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/auth/bloc.dart';
import 'package:mentorship_client/extensions/context.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/remote/requests/change_password.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';
import 'package:package_info/package_info.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Builder(
        builder: (context) => ListView(
          children: [
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Info"),
              onTap: () => _showAppInfo(context),
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log out"),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());

                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text("Change password"),
              onTap: () => _showChangePasswordDialog(context),
            ),
            ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text(
                "Delete account",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAppInfo(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    showAboutDialog(
      context: context,
      applicationIcon: Image.asset(
        "assets/images/mentorship_system_logo.png",
        width: 50,
        height: 50,
      ),
      applicationName: "Mentorship App",
      applicationVersion: "version ${packageInfo.version}, build ${packageInfo.buildNumber}",
      applicationLegalese:
          "Client app for Mentorship System. Cross-platform version initially created by Bartek Pacia.",
    );
  }

  Future<void> _showChangePasswordDialog(BuildContext theContext) async {
    final _currentPassController = TextEditingController();
    final _newPassController = TextEditingController();

    showDialog(
      context: theContext,
      builder: (context) => AlertDialog(
        title: Text("Change password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _currentPassController,
              decoration: InputDecoration(labelText: "Current password"),
            ),
            TextFormField(
              controller: _newPassController,
              decoration: InputDecoration(labelText: "New password"),
            ),
          ],
        ),
        actions: [
          FlatButton(
            child: Text("Submit"),
            onPressed: () async {
              ChangePassword changePassword = ChangePassword(
                currentPassword: _currentPassController.text,
                newPassword: _newPassController.text,
              );
              try {
                CustomResponse response =
                    await UserRepository.instance.changePassword(changePassword);
                theContext.showSnackBar(response.message);
              } on Failure catch (failure) {
                theContext.showSnackBar(failure.message);
              }

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
