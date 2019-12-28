import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/user.dart';
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
  final _bioController = TextEditingController();
  final _slackController = TextEditingController();
  final _locationController = TextEditingController();
  final _occupationController = TextEditingController();
  final _organizationController = TextEditingController();
  final _skillsController = TextEditingController();
  final _interestsController = TextEditingController();
  bool _availableToMentor;
  bool _needsMentoring;

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
          _locationController.text = state.user.location;
          _occupationController.text = state.user.occupation;
          _organizationController.text = state.user.organization;
          _skillsController.text = state.user.skills;
          _interestsController.text = state.user.interests;
          _availableToMentor = state.user.availableToMentor;
          _needsMentoring = state.user.needsMentoring;

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
                if (widget.editing)
                  RaisedButton(
                    child: Text("Update"),
                    onPressed: () => BlocProvider.of<ProfilePageBloc>(context).add(
                      ProfilePageEditSubmitted(
                        User(
                            name: _nameController.text,
                            slackUsername: _slackController.text,
                            bio: _bioController.text,
                            location: _locationController.text,
                            occupation: _occupationController.text,
                            organization: _organizationController.text,
                            interests: _interestsController.text,
                            skills: _skillsController.text,
                            needsMentoring: _needsMentoring,
                            availableToMentor: _availableToMentor),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Available to mentor"),
                          Checkbox(
                            tristate: true,
                            value: _availableToMentor,
                            onChanged: widget.editing
                                ? (value) => _availableToMentor = !_availableToMentor
                                : (value) => null,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Needs mentoring"),
                          Checkbox(
                            tristate: true,
                            value: _needsMentoring,
                            onChanged: widget.editing
                                ? (value) => _needsMentoring = !_needsMentoring
                                : (value) => null,
                          ),
                        ],
                      ),
                      _buildTextFormField("Bio", widget.editing, _bioController),
                      _buildTextFormField("Slack username", widget.editing, _slackController),
                      _buildTextFormField("Location", widget.editing, _locationController),
                      _buildTextFormField("Occupation", widget.editing, _occupationController),
                      _buildTextFormField("Organization", widget.editing, _organizationController),
                      _buildTextFormField("Skills", widget.editing, _skillsController),
                      _buildTextFormField("Interests", widget.editing, _interestsController),
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
