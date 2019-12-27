import 'package:flutter/material.dart';
import 'package:mentorship_client/remote/models/user.dart';

class UserDataList extends StatelessWidget {
  final User user;

  const UserDataList({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      _buildRow(context, "Username", user.username),
      _buildRow(context, "Slack username", user.slackUsername),
      _buildRow(context, "Available to mentor", user.availableToMentor.toString()),
      _buildRow(context, "Needs mentoring", user.needsMentoring.toString()),
      _buildRow(context, "Interests", user.interests),
      _buildRow(context, "Bio", user.bio),
      _buildRow(context, "Location", user.organization),
      _buildRow(context, "Occupation", user.occupation),
      _buildRow(context, "Organization", user.organization),
      _buildRow(context, "Skills", user.skills),
    ]);
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    if (value == null) {
      value = "---";
    }

    return Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text("$value", style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
