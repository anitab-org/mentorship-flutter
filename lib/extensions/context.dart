import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void showSnackBar(String text) {
    Scaffold.of(this).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
