import 'package:flutter/material.dart';
import 'package:mentorship_client/remote/models/user.dart';

class SendRequestScreen extends StatefulWidget {
  final User user;

  const SendRequestScreen({Key key, @required this.user}) : super(key: key);

  @override
  _SendRequestScreenState createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send request"),
      ),
      body: ListView(
        children: [
          Hero(
            tag: widget.user.id,
            child: Icon(
              Icons.person,
              size: 128,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Hero(
            tag: widget.user.username,
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    widget.user.name,
                    textScaleFactor: 2.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
