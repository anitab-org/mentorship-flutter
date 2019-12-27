import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/screens/home/pages/profile/bloc/bloc.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfilePageBloc>(
      create: (context) =>
          ProfilePageBloc(userRepository: UserRepository.instance)..add(ProfilePageShowed()),
      child: BlocBuilder<ProfilePageBloc, ProfilePageState>(builder: (context, state) {
        if (state is ProfilePageSuccess) {
          _usernameController.text = state.user.username;

          return ListView(
            children: [
              TextFormField(
                controller: _usernameController,
                enabled: false,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: UnderlineInputBorder(),
                ),
              ),
            ],
          );

          return Text("username: ${state.user.username}, name: ${state.user.name}");
        }
        if (state is ProfilePageFailure) {
          return Text(state.message);
        }

        if (state is ProfilePageLoading) {
          return LoadingIndicator();
        } else
          return Text("an error occurred");
      }),
    );
  }
}
