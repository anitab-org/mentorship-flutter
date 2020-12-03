import 'package:flutter/material.dart';

/// Centered [CircularProgressIndicator]
class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(),
    );
  }
}

Future<void> showProgressIndicator(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingIndicator(),
  );
}
