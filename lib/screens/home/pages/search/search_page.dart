import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/screens/member_profile/member_profile.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class SearchPage extends StatelessWidget {
  final SearchBarController<User> _searchBarController = SearchBarController();
  Future<List<User>> getSearchNames(String search) async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.userService.getSearchNames(search: search));
    List<User> users = [];

    for (var user in body) {
      users.add(User.fromJson(user));
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<User>(
          iconActiveColor: Theme.of(context).primaryColor,
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          searchBarController: _searchBarController,
          hintText: "Start typing",
          placeHolder: Center(
            child: Text("Enter atleast 3 letters"),
          ),
          emptyWidget: Center(
            child: Text("No users found"),
          ),
          onSearch: getSearchNames,
          minimumChars: 3,
          loader: LoadingIndicator(),
          onItemFound: (User user, int index) {
            return Container(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 36,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(user.name),
                isThreeLine: true,
                subtitle: Text(user.username),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MemberProfileScreen(user: user),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
