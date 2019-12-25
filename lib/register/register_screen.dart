import 'package:flutter/material.dart';

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

  void _toggleAvailableToMentor(bool value) {
    setState(() {
      _availableToMentor = !_availableToMentor;
    });
  }

  void _toggleNeedsMentoring(bool value) {
    setState(() {
      _needsMentoring = !_needsMentoring;
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
          Text("Available to be a:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _availableToMentor,
                    onChanged: _toggleAvailableToMentor,
                  ),
                  Text("Mentor"),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _needsMentoring,
                    onChanged: _toggleNeedsMentoring,
                  ),
                  Text("Mentee"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
