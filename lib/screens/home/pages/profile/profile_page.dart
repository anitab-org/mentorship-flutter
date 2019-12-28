import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/screens/home/pages/profile/bloc/bloc.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  final _slackController = TextEditingController();
  final _locationController = TextEditingController();
  final _occupationController = TextEditingController();
  final _organizationController = TextEditingController();
  final _skillsController = TextEditingController();
  final _interestsController = TextEditingController();

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
          _bioController.text = state.user.bio;
          _slackController.text = state.user.slackUsername;
          _locationController.text = state.user.slackUsername;
          _occupationController.text = state.user.occupation;
          _organizationController.text = state.user.organization;
          _skillsController.text = state.user.skills;
          _interestsController.text = state.user.interests;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
              shrinkWrap: true,
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
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          controller: _nameController,
                          enabled: state.editing,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Available to mentor"),
                          Checkbox(
                            value: state.user.availableToMentor,
                            onChanged: state.editing
                                ? (value) =>
                                    Toast.show("Edit mode is enabled; changing value...", context)
                                : (value) => null,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Needs mentoring"),
                          Checkbox(
                            value: state.user.needsMentoring,
                            onChanged: state.editing
                                ? (value) =>
                                    Toast.show("Edit mode is enabled; changing value...", context)
                                : (value) => null,
                          ),
                        ],
                      ),
                      _buildTextFormField("Bio", state.editing, _bioController),
                      _buildTextFormField("Slack username", state.editing, _slackController),
                      _buildTextFormField("Location", state.editing, _locationController),
                      _buildTextFormField("Occupation", state.editing, _occupationController),
                      _buildTextFormField("Organization", state.editing, _organizationController),
                      _buildTextFormField("Skills", state.editing, _skillsController),
                      _buildTextFormField("Interests", state.editing, _interestsController),
                    ],
                  ),
                )
              ],
            ),
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

  _buildTextFormField(String text, bool editing, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      enabled: editing,
      decoration: InputDecoration(
        labelText: text,
        border: UnderlineInputBorder(),
      ),
    );
  }
}
