import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/screens/home/pages/members/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/members/widgets/animated_member_list_tile.dart';
import 'package:mentorship_client/screens/member_profile/member_profile.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MembersPageBloc>(
      create: (context) =>
          MembersPageBloc(userRepository: UserRepository.instance)..add(MembersPageShowed()),
      child: BlocBuilder<MembersPageBloc, MembersPageState>(
        builder: (context, state) {
          if (state is MembersPageSuccess) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                User user = state.users[index];

                return InkWell(
                  onTap: () => _openMemberProfileScreen(context, user),
                  child: AnimatedMemberListTile(user: user),
                );
              },
            );
          }

          if (state is MembersPageFailure) {
            return Center(
              child: Column(
                children: [
                  Text(state.message),
                  RaisedButton(
                    child: Text("Retry"),
                    onPressed: () =>
                        BlocProvider.of<MembersPageBloc>(context).add(MembersPageShowed()),
                  )
                ],
              ),
            );
          }
          if (state is MembersPageLoading) {
            return LoadingIndicator();
          } else
            return Text("an error occurred");
        },
      ),
    );
  }

  void _openMemberProfileScreen(BuildContext context, User user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MemberProfileScreen(user: user),
      ),
    );
  }
}
