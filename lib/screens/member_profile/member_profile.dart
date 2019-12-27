import 'package:flutter/material.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/screens/member_profile/user_data_list.dart';
import 'package:toast/toast.dart';

class MemberProfileScreen extends StatelessWidget {
  final User user;

  const MemberProfileScreen({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Member Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  user.name,
                  textScaleFactor: 2,
                ),
              ),
            ),
            UserDataList(user: user),
            Center(
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text("Send request"),
                onPressed: () => Toast.show("Not implemented yet", context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
