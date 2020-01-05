import 'package:flutter/material.dart';
import 'package:mentorship_client/remote/models/relation.dart';

class RequestDetailScreen extends StatefulWidget {
  final Relation relation;

  const RequestDetailScreen({Key key, @required this.relation}) : super(key: key);

  @override
  _RequestDetailScreenState createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.relation.sentByMe) {}

    return Scaffold(
      appBar: AppBar(
        title: Text("Request detail"),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text("From ${widget.relation.sentByMe}"),
          ),
          Text("To be added"),
        ],
      ),
    );
  }
}
