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
      },
    );
  }

  Future<void> _showChangePasswordDialog(BuildContext topContext) async {
    final _currentPassController = TextEditingController();
    final _newPassController = TextEditingController();
    final _newPassConfirmController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    bool _passwordVisible = false;

    String _validatePasswords(String password) {
      if (password.isEmpty) {
        return "This field cannot be empty";
      } else {
        return null;
      }
    }

    String _validateConfirmPass(String password) {
      if (password.isEmpty) {
        return "This field cannot be empty";
      } else if (password != _newPassController.text) {
        return "Passwords do not match";
      } else {
        return null;
      }
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          void _togglePasswordVisibility() {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          }

          return AlertDialog(
            title: Text("Change password"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _currentPassController,
                    decoration: InputDecoration(
                      labelText: "Current password",
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) => _validatePasswords(value),
                    obscureText: !_passwordVisible,
                  ),
                  TextFormField(
                    controller: _newPassController,
                    decoration: InputDecoration(
                      labelText: "New password",
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) => _validatePasswords(value),
                    obscureText: !_passwordVisible,
                  ),
                  TextFormField(
                    controller: _newPassConfirmController,
                    decoration: InputDecoration(
                      labelText: "Confirm password",
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    validator: (value) => _validateConfirmPass(value),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: Text("Submit"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    ChangePassword changePassword = ChangePassword(
                      currentPassword: _currentPassController.text,
                      newPassword: _newPassController.text,
                    );
                    try {
                      CustomResponse response =
                          await UserRepository.instance.changePassword(changePassword);
                      context.showSnackBar(response.message);
                    } on Failure catch (failure) {
                      context.showSnackBar(failure.message);
                    }

                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
