import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/screens/home/pages/members/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/members/widgets/member_list_tile.dart';
import 'package:mentorship_client/screens/member_profile/member_profile.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class MembersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MembersPageBloc>(
        create: (context) =>
            MembersPageBloc(userRepository: UserRepository.instance)..add(MembersPageShowed(1)),
        child: _MembersPage());
  }
}

class _MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<_MembersPage> {
  int pageNumber = 1;
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
          pageNumber = (state.users.length ~/ 10);
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              User user = state.users[index];
              return index >= (state.users.length ~/ 10)
                  ? BottomLoader()
                  : InkWell(
                      onTap: () => _openMemberProfileScreen(context, user),
                      child: MemberListTile(user: user),
                    );
            },
            itemCount: state.hasReachedMax
                ? (state.users.length)
                : (state.users.length + 1),
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
      _membersPageBloc.add(MembersPageShowed(pageNumber));
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
// MembersPageBloc(userRepository: UserRepository.instance)..add(MembersPageShowed()),
// child:
// BlocBuilder<MembersPageBloc, MembersPageState>(
//   builder: (context, state) {
//     if (state is MembersPageSuccess) {
//       return ListView.builder(
//         itemCount: state.users.length,
//         itemBuilder: (context, index) {
//           User user = state.users[index];

//           return InkWell(
//             onTap: () => _openMemberProfileScreen(context, user),
//             child: MemberListTile(user: user),
//           );
//         },
//       );
//     }

//     if (state is MembersPageFailure) {
//       return Center(
//         child: Column(
//           children: [
//             Text(state.message),
//             RaisedButton(
//               child: Text("Retry"),
//               onPressed: () =>
//                   BlocProvider.of<MembersPageBloc>(context).add(MembersPageShowed()),
//             )
//           ],
//         ),
//       );
//     }
//     if (state is MembersPageLoading) {
//       return LoadingIndicator();
//     } else
//       return Text("an error occurred");
//   },
// );
