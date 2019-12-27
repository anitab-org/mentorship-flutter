import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/screens/home/pages/profile/bloc/bloc.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class ProfilePage extends StatefulWidget {
  final bool editing;

  const ProfilePage({Key key, this.editing}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfilePageBloc>(
      create: (context) =>
          ProfilePageBloc(userRepository: UserRepository.instance)..add(ProfilePageShowed()),
      child: BlocBuilder<ProfilePageBloc, ProfilePageState>(builder: (context, state) {
        if (state is ProfilePageSuccess) {
          _nameController.text = state.user.name;
          _usernameController.text = state.user.username;
          _emailController.text = state.user.email;

          return ListView(
            children: [
              Center(
                child: ClipOval(
                  child: Container(
                    color: Colors.deepPurple,
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: _nameController,
                        enabled: widget.editing,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
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
