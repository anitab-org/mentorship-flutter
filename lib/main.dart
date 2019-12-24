import 'package:flutter/material.dart';
import 'package:mentorship_client/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Systers Mentorship',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.lightBlueAccent,
      ),
      home: LoginScreen(),
    );
  }
}
