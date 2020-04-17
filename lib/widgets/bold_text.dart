import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final int maxLines;

  const BoldText(this.firstText, this.secondText, {Key key, this.maxLines = 3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyText2,
        children: [
          TextSpan(text: firstText, style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: secondText)
        ],
      ),
    );
  }
}
