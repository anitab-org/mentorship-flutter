import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/auth/auth_bloc.dart';
import 'package:mentorship_client/auth/auth_event.dart';
import 'package:mentorship_client/screens/home/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/members/members_page.dart';
import 'package:mentorship_client/screens/home/pages/profile/profile_page.dart';
import 'package:mentorship_client/screens/home/pages/stats/stats_page.dart';
import 'package:mentorship_client/screens/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  void _onTapNavbar(int index, BuildContext context) {
    HomeEvent event;

    switch (index) {
      case 0:
        event = StatsPageSelected();
        break;
      case 1:
        event = ProfilePageSelected();
        break;
      case 2:
        event = RelationPageSelected();
        break;
      case 3:
        event = MembersPageSelected();
        break;
      case 4:
        event = RequestsPageSelected();
        break;
      default:
        event = StatsPageSelected();
        Logger.root.warning("BottomNavBar: Index $index is not valid!");
    }

    BlocProvider.of<HomeBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  ),
                )
              ],
              title: Text(state.title),
            ),
            body: Padding(
              padding: EdgeInsets.all(8),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomePageStats) {
                    return StatsPage();
                  }

                  if (state is HomePageMembers) {
                    return MembersPage();
                  }

                  if (state is HomePageProfile) {
                    return ProfilePage();
                  }

                  return Center(
                    child: Column(
                      children: [
                        Text("PAGE TITLE: ${state.title}"),
                        RaisedButton(
                          child: Text("Log out"),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) => _onTapNavbar(index, context),
              type: BottomNavigationBarType.fixed,
              currentIndex: state.index,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
                BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profile")),
                BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("Relation")),
                BottomNavigationBarItem(icon: Icon(Icons.people_outline), title: Text("Members")),
                BottomNavigationBarItem(icon: Icon(Icons.comment), title: Text("Requests"))
              ],
            ),
          );
        },
      ),
    );
  }
}
