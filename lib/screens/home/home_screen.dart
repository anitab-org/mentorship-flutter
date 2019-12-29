import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/screens/home/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/members/members_page.dart';
import 'package:mentorship_client/screens/home/pages/profile/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/profile/profile_page.dart';
import 'package:mentorship_client/screens/home/pages/relation/relation_page.dart';
import 'package:mentorship_client/screens/home/pages/requests/requests_page.dart';
import 'package:mentorship_client/screens/home/pages/stats/stats_page.dart';
import 'package:mentorship_client/screens/settings/settings_screen.dart';
import 'package:toast/toast.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfilePageBloc>(
          // I think its too high in the widget tree, but I couldn't find a better solution
          create: (context) => ProfilePageBloc(userRepository: UserRepository.instance),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
      ],
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
                ),
              ],
              title: Text(state.title),
            ),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomePageStats) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: StatsPage(),
                  );
                }

                if (state is HomePageProfile) {
                  print("type" + BlocProvider.of<HomeBloc>(context).toString());
                  print("type" + BlocProvider.of<ProfilePageBloc>(context).toString());
                  final ProfilePageBloc bloc = BlocProvider.of<ProfilePageBloc>(context);

                  bool editing = false;
                  if (state is HomePageProfileEditing) {
                    editing = true;
                  }
                  return ProfilePage(bloc: bloc, editing: editing);
                }

                if (state is HomePageRelation) {
                  return RelationPage();
                }

                if (state is HomePageMembers) {
                  return MembersPage();
                }

                if (state is HomePageRequests) {
                  return RequestsPage();
                }

                return Center(
                  child: Text("Error: Unknown HomePageState"),
                );
              },
            ),
            bottomNavigationBar: BottomNavyBar(
              showElevation: false,
              onItemSelected: (index) => _onTapNavbar(index, context),
              selectedIndex: state.index,
              items: [
                BottomNavyBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home"),
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Theme.of(context).accentColor,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Profile"),
                  inactiveColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.people),
                  title: Text("Relation"),
                  inactiveColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.people_outline),
                  title: Text("Members"),
                  inactiveColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.comment),
                  title: Text("Requests"),
                  inactiveColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
                )
              ],
            ),
            floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                bool visible = false;
                bool editing = false;

                switch (state.runtimeType) {
                  case HomePageProfile:
                    visible = true;
                    editing = false;
                    break;
                  case HomePageProfileEditing:
                    visible = true;
                    editing = true;
                    break;
                  default:
                    visible = false;
                    editing = false;
                }

                return AnimatedOpacity(
                  opacity: visible ? 1 : 0,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 500),
                  child: FloatingActionButton(
                    onPressed: () {
                      Toast.show("Not implemented yet", context);

                      if (state is HomePageProfile) {
                        BlocProvider.of<HomeBloc>(context).add(HomeProfilePageEditClicked());
                      } else {
                        BlocProvider.of<HomeBloc>(context).add(HomeProfilePageEditSubmitted());
                      }
                    },
                    child: Icon(
                      editing ? Icons.save : Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
