import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/repositories/task_repository.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/screens/home/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/members/members_page.dart';
import 'package:mentorship_client/screens/home/pages/profile/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/profile/profile_page.dart';
import 'package:mentorship_client/screens/home/pages/relation/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/relation/relation_page.dart';
import 'package:mentorship_client/screens/home/pages/requests/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/requests/requests_page.dart';
import 'package:mentorship_client/screens/home/pages/stats/stats_page.dart';
import 'package:mentorship_client/screens/settings/settings_screen.dart';
import 'package:toast/toast.dart';

import 'pages/members/bloc/members_page_bloc.dart';
import 'pages/members/bloc/members_page_event.dart';
import 'pages/stats/bloc/stats_page_bloc.dart';
import 'pages/stats/bloc/stats_page_event.dart';

/// [HomeScreen] is the main screen in the app. It's what user sees after successfully logging in.
/// HomeScreen's main task is to have scaffold with AppBar and BottomNavBar. Content (i.e body)
/// is provided by one of 5 Pages - [StatsPage], [ProfilePage], [RelationPage], [MembersPage] and [RequestsPage].
/// HomeScreen manages displaying of these pages using BottomNavBar and PageView.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();
  bool _isContainerVisible = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // I think its too high in the widget tree, but I couldn't find a better solution

        BlocProvider<ProfilePageBloc>(
          create: (context) =>
              ProfilePageBloc(userRepository: UserRepository.instance)..add(ProfilePageShowed()),
          child: ProfilePage(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<RelationPageBloc>(
          create: (context) => RelationPageBloc(
            relationRepository: RelationRepository.instance,
            taskRepository: TaskRepository.instance,
          )..add(RelationPageShowed()),
          child: RelationPage(),
        ),
        BlocProvider<RequestsPageBloc>(
          create: (context) => RequestsPageBloc(
            relationRepository: RelationRepository.instance,
          )..add(RequestsPageShowed()),
          child: RequestsPage(),
        ),

        BlocProvider<StatsPageBloc>(
          create: (context) => StatsPageBloc(userRepository: UserRepository.instance)
            ..add(
              StatsPageShowed(),
            ),
        ),
        BlocProvider<MembersPageBloc>(
          create: (context) =>
              MembersPageBloc(userRepository: UserRepository.instance)..add(MembersPageShowed()),
          child: MembersPage(),
        ),
      ],
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          pageController.animateToPage(state.index,
              duration: Duration(milliseconds: 450), curve: Curves.ease);
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
                bottom: PreferredSize(
                  preferredSize: Size(
                    double.infinity,
                    MediaQuery.of(context).size.height * 0.008,
                  ),
                  child: OfflineBuilder(
                    connectivityBuilder: (
                      BuildContext context,
                      ConnectivityResult connectivity,
                      Widget child,
                    ) {
                      final bool connected = connectivity != ConnectivityResult.none;
                      if (connected) {
                        Future.delayed(Duration(seconds: 2)).then((v) {
                          if (this.mounted)
                            setState(() {
                              _isContainerVisible = false;
                            });
                        });
                      }
                      return ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(0.0),
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            child: connected
                                ? _isContainerVisible ? Container() : Container()
                                : Container(
                                    color: Colors.red,
                                    height: 25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'You are offline',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(width: 8.0),
                                        SizedBox(
                                          width: 12.0,
                                          height: 12.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          child,
                        ],
                      );
                    },
                    child: Container(),
                  ),
                ),
              ),
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
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
            );
          },
        ),
      ),
    );
  }
}
