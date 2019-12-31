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

/// [HomeScreen] is the main screen in the app. It's what user sees after successfully logging in.
/// HomeScreen's main task is to have scaffold with AppBar and BottomNavBar. Content (i.e body)
/// is provided by one of 5 Pages - [StatsPage], [ProfilePage], [RelationPage], [MembersPage] and [RequestsPage].
/// HomeScreen manages displaying of these pages using BottomNavBar and PageView.
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
          int delta = state.index - pageController.page.toInt();

          if (delta < -1 || delta > 1) {
            pageController.jumpToPage(state.index);
          } else
            pageController.animateToPage(state.index,
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
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
                onPageChanged: (index) => // This triggers when the user swipes screens
                    BlocProvider.of<HomeBloc>(context).add(HomeEvent.fromIndex(index)),
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
                onItemSelected:
                    (index) => // This triggers when the user clicks item on BottomNavyBar
                        BlocProvider.of<HomeBloc>(context).add(HomeEvent.fromIndex(index)),
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
