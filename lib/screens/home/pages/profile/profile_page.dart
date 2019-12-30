import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/screens/home/pages/profile/bloc/bloc.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class ProfilePage extends StatefulWidget {
  final bool editing;

  const ProfilePage({Key key, this.editing}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfilePageBloc bloc;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController(); // not changeable
  final _emailController = TextEditingController(); // not changeable
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
    ProfilePageBloc bloc = BlocProvider.of<ProfilePageBloc>(context);

    _nameController..addListener(() => bloc.user.name = _nameController.text);
    _bioController..addListener(() => bloc.user.bio = _bioController.text);
    _slackController..addListener(() => bloc.user.slackUsername = _slackController.text);
    _locationController..addListener(() => bloc.user.location = _locationController.text);
    _occupationController..addListener(() => bloc.user.occupation = _occupationController.text);
    _organizationController
      ..addListener(() => bloc.user.organization = _organizationController.text);
    _skillsController..addListener(() => bloc.user.skills = _skillsController.text);
    _interestsController..addListener(() => bloc.user.interests = _interestsController.text);
    // _availableToMentor
    // _needsMentoring // TODO: Implement!

    bloc.close();

    return BlocBuilder<ProfilePageBloc, ProfilePageState>(builder: (context, state) {
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

        return _createPage(context, state.user, false);
      }
      if (state is ProfilePageEditing) {
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

        return _createPage(context, state.user, true);
      }

      if (state is ProfilePageFailure) {
        return Text(state.message);
      }
      if (state is ProfilePageLoading) {
        return LoadingIndicator();
      }

      if (state is ProfilePageInitial) {
        return Text("ProfilePageInitial");
      } else
        return Text("Unknown ProfilePageState");
    });
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

  Widget _createPage(BuildContext context, User user, bool editing) {
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
                    enabled: editing,
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
                      onChanged: editing
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
                      onChanged:
                          editing ? (value) => _needsMentoring = !_needsMentoring : (value) => null,
                    ),
                  ],
                ),
                _buildTextFormField("Bio", editing, _bioController),
                _buildTextFormField("Slack username", editing, _slackController),
                _buildTextFormField("Location", editing, _locationController),
                _buildTextFormField("Occupation", editing, _occupationController),
                _buildTextFormField("Organization", editing, _organizationController),
                _buildTextFormField("Skills", editing, _skillsController),
                _buildTextFormField("Interests", editing, _interestsController),
              ],
            ),
          )
        ],
      ),
    );
  }
}
