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
        // I think its too high in the widget tree, but I couldn't find a better solution
        BlocProvider<ProfilePageBloc>(
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
                if (state is HomeScreenStats) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: StatsPage(),
                  );
                }

                if (state is HomeScreenProfile) {
                  final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
                  final ProfilePageBloc profileBloc = BlocProvider.of<ProfilePageBloc>(context);
                  Logger.root.warning("homeBloc: ${homeBloc.toString()}");
                  Logger.root.warning("profileBloc: ${profileBloc.toString()}");

                  profileBloc.add(ProfilePageShowed());

                  bool editing = false;
                  if (profileBloc.state is ProfilePageEditing) {
                    editing = true;
                  }

                  return ProfilePage(editing: editing);
                }

                if (state is HomeScreenRelation) {
                  return RelationPage();
                }

                if (state is HomeScreenMembers) {
                  return MembersPage();
                }

                if (state is HomeScreenRequests) {
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

                if (state is HomeScreenProfile) {
                  visible = true;
                }

                return Text("ok");
//                ProfilePageBloc profileBloc = BlocProvider.of<ProfilePageBloc>(context);
//
//                ProfilePageState profileState;
//                if (profileBloc != null) {
//                  profileState = profileBloc.state;
//                } else {
//                  profileState = ProfilePageFailure("LOL");
//                }
//
//                if (profileState is ProfilePageEditing) {
//                  editing = true;
//                }
//
//                return AnimatedOpacity(
//                  opacity: visible ? 1 : 0,
//                  curve: Curves.ease,
//                  duration: Duration(milliseconds: 500),
//                  child: FloatingActionButton(
//                    onPressed: () {
//                      Toast.show("Not implemented yet", context);
//
//                      if (state is HomePageProfile) {
//                        profileBloc.add(ProfilePageEditStarted());
//                        if (profileState is ProfilePageEditing) {
//                          profileBloc.add(ProfilePageEditSubmitted(profileState.user));
//                        }
//                      }
//                    },
//                    child: Icon(
//                      editing ? Icons.save : Icons.edit,
//                      color: Colors.white,
//                    ),
//                  ),
//                );
              },
            ),
          );
        },
      ),
    );
  }
}
