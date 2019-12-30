import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final pageController = PageController();

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
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          pageController.jumpToPage(state.index);
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  if (state is HomeScreenMembers)
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => Toast.show("Not implemented yet", context),
                    ),
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
              body: PageView(
                onPageChanged: (index) {
                  // FIXME WHILE SCROLLING
                  print("onPageChanged: $index");

                  BlocProvider.of<HomeBloc>(context).add(HomeEvent.fromIndex(index));
                },
                controller: pageController,
                children: [
                  StatsPage(),
                  ProfilePage(),
                  RelationPage(),
                  MembersPage(),
                  RequestsPage(),
                ],
              ),
              bottomNavigationBar: BottomNavyBar(
                showElevation: false,
                onItemSelected: (index) =>
                    BlocProvider.of<HomeBloc>(context).add(HomeEvent.fromIndex(index)),
                // FIXME SINGLE SELECT
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
                builder: (context, homeState) {
                  final bool visible = homeState is HomeScreenProfile;

                  ProfilePageBloc profileBloc = BlocProvider.of<ProfilePageBloc>(context);

                  return BlocBuilder<ProfilePageBloc, ProfilePageState>(
                    builder: (context, profileState) {
                      bool editing = false;

                      if (profileState is ProfilePageEditing) {
                        editing = true;
                      }

                      return AnimatedOpacity(
                        opacity: visible ? 1 : 0,
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 500),
                        child: FloatingActionButton(
                          onPressed: () {
                            if (state is HomeScreenProfile) {
                              profileBloc.add(ProfilePageEditStarted());
                              if (profileState is ProfilePageEditing) {
                                profileBloc.add(ProfilePageEditSubmitted(profileBloc.user));
                              }
                            }
                          },
                          child: Icon(
                            editing ? Icons.save : Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
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
