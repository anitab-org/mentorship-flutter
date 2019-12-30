import 'package:flutter/material.dart';
import 'package:mentorship_client/remote/models/user.dart';

class AnimatedMemberListTile extends StatefulWidget {
  final User user;

  AnimatedMemberListTile({Key key, @required this.user}) : super(key: key);

  @override
  _AnimatedMemberListTileState createState() => _AnimatedMemberListTileState();
}

class _AnimatedMemberListTileState extends State<AnimatedMemberListTile> {
  bool _lock = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      setState(() {
        _lock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: Icon(
        Icons.person,
        size: 36,
        color: Theme.of(context).primaryColor,
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

    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: _lock ? 1 : 0,
      curve: Curves.easeIn,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
        padding: _lock ? EdgeInsets.zero : EdgeInsets.only(top: MediaQuery.of(context).size.height),
        child: ListTile(
          isThreeLine: true,
          leading: Icon(
            Icons.person,
            size: 36,
            color: Theme.of(context).primaryColor,
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
        ),
      ),
    );
  }
}
