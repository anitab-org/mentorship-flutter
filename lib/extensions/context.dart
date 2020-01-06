import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

extension BuildContextX on BuildContext {
  void showSnackBar(String text) {
    Scaffold.of(this).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void toast(String text) {
    Toast.show(text, this);
  }
}
