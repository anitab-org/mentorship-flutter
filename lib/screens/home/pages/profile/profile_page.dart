import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/extensions/context.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/screens/home/pages/profile/bloc/bloc.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  bool editing = false;

  @override
  void initState() {
    context.bloc<ProfilePageBloc>()..add(ProfilePageShowed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = User();
    return Scaffold(
      floatingActionButton:
          BlocBuilder<ProfilePageBloc, ProfilePageState>(builder: (context, state) {
        bool editing = false;
        if (state is ProfilePageEditing) {
          editing = true;
        }
        return FloatingActionButton(
          onPressed: () {
            //ignore: close_sinks
            final bloc = BlocProvider.of<ProfilePageBloc>(context);

            if (state is ProfilePageEditing) {
              _formKey.currentState.save();
              user.availableToMentor = _availableToMentor;
              user.needsMentoring = _needsMentoring;

              user.name = _nameController.text;
              user.username = _usernameController.text;
              user.email = _emailController.text;
              user.bio = _bioController.text;
              user.slackUsername = _slackController.text;
              user.location = _locationController.text;
              user.occupation = _occupationController.text;
              user.organization = _organizationController.text;
              user.skills = _skillsController.text;
              user.interests = _interestsController.text;

              bloc.add(ProfilePageEditSubmitted(user));
            } else if (state is ProfilePageSuccess) {
              bloc.add(ProfilePageEditStarted());
            }
          },
          child: Icon(
            editing ? Icons.save : Icons.edit,
            color: Colors.white,
          ),
        );
      }),
      body: BlocListener<ProfilePageBloc, ProfilePageState>(
        listener: (context, state) {
          if (state.message != null) {
            context.showSnackBar(state.message);
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
            if (_availableToMentor == null) _availableToMentor = state.user.availableToMentor;
            if (_needsMentoring == null) _needsMentoring = state.user.needsMentoring;
          }
        },
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
            if (_availableToMentor == null) _availableToMentor = state.user.availableToMentor;
            if (_needsMentoring == null) _needsMentoring = state.user.needsMentoring;

            return _createPage(context, state.user, false);
          }
          if (state is ProfilePageEditing) {
            print(_interestsController.text);
            return _createPage(context, state.user, true);
          }

          if (state is ProfilePageFailure) {
            return Text(state.message);
          }
          if (state is ProfilePageLoading) {
            return LoadingIndicator();
          }

          if (state is ProfilePageInitial) {
            return LoadingIndicator();
          } else
            return Text("Error: Unknown ProfilePageState");
        }),
      ),
    );
  }

  Widget _createPage(BuildContext context, User user, bool editing) {
    return Opacity(
      opacity: editing ? 1.0 : 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 24),
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
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextFormField(
                      controller: _nameController,
                      enabled: editing,
                      onSaved: (value) {
                        user.name = value;
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: const UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _usernameController,
                    enabled: false,
                    onSaved: (value) {
                      user.name = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "Username",
                      border: const UnderlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    enabled: false,
                    onSaved: (value) {
                      user.email = value;
                    },
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: const UnderlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Available to mentor"),
                      Checkbox(
                        value: _availableToMentor,
                        onChanged: editing
                            ? (value) {
                                setState(() {
                                  _availableToMentor = value;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Needs mentoring"),
                      Checkbox(
                        value: _needsMentoring,
                        onChanged: editing
                            ? (value) {
                                setState(() {
                                  _needsMentoring = value;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                  _buildTextFormField(
                    "Bio",
                    editing,
                    _bioController,
                    (value) {
                      user.bio = value;
                    },
                  ),
                  _buildTextFormField("Slack username", editing, _slackController, (value) {
                    user.slackUsername = value;
                  }),
                  _buildTextFormField("Location", editing, _locationController, (value) {
                    user.location = value;
                  }),
                  _buildTextFormField("Occupation", editing, _occupationController, (value) {
                    user.occupation = value;
                  }),
                  _buildTextFormField("Organization", editing, _organizationController, (value) {
                    user.organization = value;
                  }),
                  _buildTextFormField("Skills", editing, _skillsController, (value) {
                    user.skills = value;
                  }),
                  _buildTextFormField("Interests", editing, _interestsController, (value) {
                    user.interests = value;
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildTextFormField(
      String text, bool editing, TextEditingController controller, Function(String) onSaved) {
    return TextFormField(
      controller: controller,
      enabled: editing,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: text,
        border: UnderlineInputBorder(),
      ),
    );
  }
}
