import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/screens/home/pages/members/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/members/widgets/member_list_tile.dart';
import 'package:mentorship_client/screens/home/pages/search/search_page.dart';
import 'package:mentorship_client/screens/member_profile/member_profile.dart';
import 'package:toast/toast.dart';

class MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final _scrollController = ScrollController();
  // ignore: dart.core.Sink
  MembersPageBloc _membersPageBloc;
  final _scrollThreshold = 10.0;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _membersPageBloc = BlocProvider.of<MembersPageBloc>(context);
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MembersPageBloc, MembersPageState>(listener: (context, state) {
      if (state is MembersPageShowed) {
        _refreshCompleter?.complete();
        _refreshCompleter = Completer();
      }
    }, builder: (context, state) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await DataConnectionChecker().hasConnection) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            } else {
              Toast.show("You are offline", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            }
          },
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        body: BlocBuilder<MembersPageBloc, MembersPageState>(
          builder: (context, state) {
            if (state is MembersPageFailure) {
              return Center(
                child: Text('Failed to get users'),
              );
            }
            if (state is MembersPageSuccess) {
              if (state.users.isEmpty) {
                return Center(
                  child: Text('No users'),
                );
              }
              return RefreshIndicator(
                onRefresh: () {
                  BlocProvider.of<MembersPageBloc>(context).add(
                    MembersPageRefresh(),
                  );
                  return _refreshCompleter.future;
                },
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    bool _reachedEnd = index > state.users.length - 1;
                    User user = (!_reachedEnd) ? state.users[index] : null;
                    return _reachedEnd
                        ? BottomLoader()
                        : InkWell(
                            onTap: () => _openMemberProfileScreen(context, user),
                            child: MemberListTile(user: user),
                          );
                  },
                  itemCount: state.hasReachedMax ? (state.users.length) : (state.users.length + 1),
                  controller: _scrollController,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    });
  }

  void _openMemberProfileScreen(BuildContext context, User user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MemberProfileScreen(user: user),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (await DataConnectionChecker().hasConnection) {
        _membersPageBloc.add(MoreMembers());
      } else {
        Toast.show("You are offline", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
