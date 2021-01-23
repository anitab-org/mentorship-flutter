import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/extensions/context.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/repositories/auth_repository.dart';
import 'package:mentorship_client/remote/requests/register.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final _nameFormKey = GlobalKey<FormState>();
  final _usernameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _confirmPasswordFormKey = GlobalKey<FormState>();

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

  String _validateUserName(String value) {
    if (value.length < 4) {
      return "Username cannot be less than 4 characters";
    } else if (value.length > 26) {
      return "Username cannot be more 26 characters";
    }
    return null;
  }

  String _validateEmail(String value) {
    if (!EmailValidator.validate(value)) {
      return "Email is not valid";
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return "Password should be longer than 8 characters"; // TODO: Add regex based validation
    } else if (value.length > 64) {
      return "Password should be no longer than 64 characters"; // TODO: Add regex based validation
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
          Form(
            key: _nameFormKey,
            child: TextFormField(
              onChanged: (val) => _nameFormKey.currentState.validate(),
              controller: _nameController,
              validator: _validateName,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: spacing),
          Form(
            key: _usernameFormKey,
            child: TextFormField(
              onChanged: (val) => _usernameFormKey.currentState.validate(),
              controller: _usernameController,
              validator: _validateUserName,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: spacing),
          Form(
            key: _emailFormKey,
            child: TextFormField(
              onChanged: (val) => _emailFormKey.currentState.validate(),
              controller: _emailController,
              validator: _validateEmail,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: spacing),
          Form(
            key: _passwordFormKey,
            child: TextFormField(
              onChanged: (val) => _passwordFormKey.currentState.validate(),
              controller: _passwordController,
              validator: _validatePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: _togglePasswordVisibility,
                ),
                labelText: "Enter password",
                border: OutlineInputBorder(),
              ),
              obscureText: !_passwordVisible,
            ),
          ),
          SizedBox(height: spacing),
          Form(
            key: _confirmPasswordFormKey,
            child: TextFormField(
              onChanged: (val) =>
                  _confirmPasswordFormKey.currentState.validate(),
              controller: _confirmPasswordController,
              validator: _validatePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: _togglePasswordVisibility,
                ),
                labelText: "Confirm password",
                border: OutlineInputBorder(),
              ),
              obscureText: !_passwordVisible,
            ),
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
                child: ConditionsText(),
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
                  onPressed: _acceptedTermsAndConditions && signupButtonEnabled
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

class ConditionsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            style: TextStyle(
              color: Colors.black,
            ),
            text:
                "By checking this box, I affirm that I have read and accept to be bound by the "
                "AnitaB.org ",
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch("https://ghc.anitab.org/code-of-conduct/");
              },
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            text: "Code of Conduct",
          ),
          TextSpan(
            style: TextStyle(
              color: Colors.black,
            ),
            text: ", ",
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch("https://anitab.org/terms-of-use/");
              },
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            text: "Terms",
          ),
          TextSpan(
            style: TextStyle(
              color: Colors.black,
            ),
            text: ", and ",
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch("https://anitab.org/privacy-policy/");
              },
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            text: "Privacy Policy",
          ),
          TextSpan(
            style: TextStyle(
              color: Colors.black,
            ),
            text:
                ". Further, I consent to the use of my information for the stated purpose.",
          ),
        ],
      ),
    );
  }
}
