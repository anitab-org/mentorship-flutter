import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/screens/home/pages/members/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/members/widgets/member_list_tile.dart';
import 'package:mentorship_client/screens/member_profile/member_profile.dart';

class MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final _scrollController = ScrollController();
  // ignore: dart.core.Sink
  MembersPageBloc _membersPageBloc;
  final _scrollThreshold = 10.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _membersPageBloc = BlocProvider.of<MembersPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembersPageBloc, MembersPageState>(
      builder: (context, state) {
        if (state is MembersPageFailure) {
          return Center(
            child: Text('failed to get users'),
          );
        }
        if (state is MembersPageSuccess) {
          if (state.users.isEmpty) {
            return Center(
              child: Text('no users'),
            );
          }
          return ListView.builder(
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
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
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

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _membersPageBloc.add(MembersPageShowed());
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
