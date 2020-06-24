import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/extensions/context.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/repositories/auth_repository.dart';
import 'package:mentorship_client/remote/requests/register.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

/// This screen will let the user to sign up into the system using name, username,
/// email and password.
/// It doesn't use BLoC pattern,
class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: ListView(
        children: [
          Container(
            height: 64,
            child: Center(
              child: Text("Sign Up", textScaleFactor: 2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: RegisterForm(),
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _availableToMentor = false;
  bool _needsMentoring = false;
  bool _acceptedTermsAndConditions = false;
  int _radiovalue;
  bool registering = false;
  bool signupButtonEnabled = true;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Email cannot be empty"; // TODO: Add regex based validation
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Password cannot be empty"; // TODO: Add regex based validation
    }
    return null;
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radiovalue = value;
      switch (_radiovalue) {
        case 0:
          _availableToMentor = !_availableToMentor;
          break;
        case 1:
          _needsMentoring = !_needsMentoring;
          break;
        case 2:
          _needsMentoring = !_needsMentoring;
          _availableToMentor = !_availableToMentor;
          break;
      }
    });
  }

  void _toggleTermsAndConditions(bool value) {
    setState(() {
      _acceptedTermsAndConditions = !_acceptedTermsAndConditions;
    });
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 12.0;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            validator: _validateName,
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: spacing),
          TextFormField(
            controller: _usernameController,
            validator: _validateName,
            decoration: InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: spacing),
          TextFormField(
            controller: _emailController,
            validator: _validateEmail,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: spacing),
          TextFormField(
            controller: _passwordController,
            validator: _validatePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: _togglePasswordVisibility,
              ),
              labelText: "Enter password",
              border: OutlineInputBorder(),
            ),
            obscureText: !_passwordVisible,
          ),
          SizedBox(height: spacing),
          TextFormField(
            controller: _confirmPasswordController,
            validator: _validatePassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: _togglePasswordVisibility,
              ),
              labelText: "Confirm password",
              border: OutlineInputBorder(),
            ),
            obscureText: !_passwordVisible,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text("Available to be a:"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _radiovalue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text("Mentor"),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: _radiovalue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text("Mentee"),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: _radiovalue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text("Both"),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _acceptedTermsAndConditions,
                onChanged: _toggleTermsAndConditions,
              ),
              Flexible(
                child: Text("I affirm that I have read and accept to be bound by the "
                    "AnitaB.org Code of Conduct, Terms and Privacy Policy. Further, "
                    "I consent to use of my information for the stated purpose."),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                registering ? LoadingIndicator() : Container(),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text("Sign up"),
                  onPressed: signupButtonEnabled
                      ? () {
                          setState(() {
                            registering = true;

                            signupButtonEnabled = false;
                          });
                          _register(context);
                        }
                      : null,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: FlatButton(
              splashColor: Theme.of(context).accentColor,
              child: Text("Login"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        ],
      ),
    );
  }

  void _register(BuildContext context) async {
    final Register register = Register(
      name: _nameController.text.trim(),
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      acceptedTermsAndConditions: _acceptedTermsAndConditions,
      needsMentoring: _needsMentoring,
      availableToMentor: _availableToMentor,
    );

    String message;
    try {
      await AuthRepository.instance.register(register);
      message = "Great! Now confirm you email address";
    } on Failure catch (failure) {
      Logger.root.severe(failure.message);
      message = failure.message;
    } on Exception catch (exception) {
      Logger.root.severe(exception.toString());
      message = exception.toString();
    }
    context.showSnackBar(message);
    setState(() {
      registering = false;
      signupButtonEnabled = true;
    });
  }
}
