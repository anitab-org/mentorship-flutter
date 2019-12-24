import 'package:flutter/material.dart';
import 'package:mentorship_client/register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        children: [
          Image.asset("assets/images/mentorship_system_logo.png"),
          Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter username or email",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: _togglePasswordVisibility,
                      ),
                      labelText: "Enter password",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                    obscureText: !_passwordVisible,
                  ),
                  SizedBox(height: 32),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text("Login".toUpperCase()),
                    onPressed: () => null,
                  ),
                  OutlineButton(
                    child: Text("Sign up".toUpperCase()),
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
