import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/extensions/context.dart';
import 'package:mentorship_client/remote/repositories/auth_repository.dart';
import 'package:mentorship_client/remote/requests/google_signin.dart';
import 'package:mentorship_client/remote/requests/login.dart';
import 'package:mentorship_client/screens/login/bloc/bloc.dart';
import 'package:mentorship_client/screens/register/register_screen.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(AuthRepository.instance, BlocProvider.of<AuthBloc>(context)),
        child: ListView(
          children: [
            Image.asset("assets/images/mentorship_system_logo.png"),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _passwordVisible = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email'
    ],
  );

  Future<void> _onGoogleSignInButtonPressed() async {
    BlocProvider.of<LoginBloc>(context).add(
         GoogleSignInButtonPressed()
      );
  }

  void _onLoginButtonPressed() {
    if (!_formKey.currentState.validate()) return;

    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        Login(username: _usernameController.text.trim(), password: _passwordController.text),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  String _validateUsername(String username) {
    if (username.isEmpty) {
      return "Username is empty";
    }
    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return "Password is empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          context.showSnackBar(state.message);
        }
        if (state is LoginSuccess) {
          context.showSnackBar("Login successful");
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                validator: _validateUsername,
                decoration: InputDecoration(
                  labelText: "Enter username or email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
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
              SizedBox(height: 12),
              Container(
                height: 48,
                child: (state is LoginInProgress) ? LoadingIndicator() : null,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) => Center(
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text("Login".toUpperCase()),
                    onPressed: state is! LoginInProgress ? _onLoginButtonPressed : null,
                  ),
                ),
              ),
              Center(
                child: FlatButton(
                  splashColor: Theme.of(context).accentColor,
                  child: Text("Sign up".toUpperCase()),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                ),
              ),
              SignInButton(
                Buttons.Google,
                onPressed:  _onGoogleSignInButtonPressed,
                elevation: 5,
              ),
            ],
          ),
        );
      }),
    );
  }
}
