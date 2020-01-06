import 'package:flutter/material.dart';
import 'package:mentorship_client/remote/models/user.dart';

class MemberListTile extends StatefulWidget {
  final User user;

  MemberListTile({Key key, @required this.user}) : super(key: key);

  @override
  _MemberListTileState createState() => _MemberListTileState();
}

class _MemberListTileState extends State<MemberListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: Hero(
        tag: widget.user.id,
        child: Icon(
          Icons.person,
          size: 36,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(widget.user.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.user.requestStatus(),
          ),
          Text("Interests: ${widget.user.interests ?? "---"}"),
        ],
      ),
    );
  }
}
