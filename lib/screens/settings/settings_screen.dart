import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/auth/bloc.dart';
import 'package:mentorship_client/extensions/context.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/remote/requests/change_password.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';
import 'package:mentorship_client/screens/settings/about.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

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
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage())),
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log out"),
              onTap: () => _showConfirmLogoutDialog(context),
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

  void _showConfirmLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Log Out'),
            content: Text('Are you sure you want to logout?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Confirm'),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _showChangePasswordDialog(BuildContext theContext) async {
    final _currentPassController = TextEditingController();
    final _newPassController = TextEditingController();
    showDialog(
      context: theContext,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Change password"),
        content: Column(
          // Then, the content of your dialog.
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
              Navigator.of(context).pop();
              showloader(context);
              try {
                CustomResponse response =
                    await UserRepository.instance.changePassword(changePassword);
                theContext.showSnackBar(response.message);
              } on Failure catch (failure) {
                theContext.showSnackBar(failure.message);
              }
              Navigator.of(theContext).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> showloader(BuildContext context) {
    return showDialog(
      context: context,
      child: LoadingIndicator(),
    );
  }
}
