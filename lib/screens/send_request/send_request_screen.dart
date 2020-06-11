import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/extensions/context.dart';
import 'package:mentorship_client/extensions/datetime.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/requests/relation_requests.dart';
import 'package:mentorship_client/screens/send_request/bloc/bloc.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';
import 'package:toast/toast.dart';

class SendRequestScreen extends StatefulWidget {
  final User otherUser;
  final User currentUser;

  const SendRequestScreen({Key key, @required this.otherUser, @required this.currentUser})
      : super(key: key);

  @override
  _SendRequestScreenState createState() => _SendRequestScreenState();
}

enum Role { mentor, mentee }

class _SendRequestScreenState extends State<SendRequestScreen> {
  Role _role = Role.mentee;
  DateTime _endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendRequestBloc>(
      create: (context) => SendRequestBloc(relationRepository: RelationRepository.instance),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Send request"),
        ),
        body: BlocListener<SendRequestBloc, SendRequestState>(
          listener: (context, state) {
            if (state.message != null) {
              context.showSnackBar(state.message);
              Navigator.of(context).pop();
              state.message = null;
            }
          },
          child: Builder(
            builder: (context) => _buildBody(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    //ignore: close_sinks
    SendRequestBloc bloc = BlocProvider.of<SendRequestBloc>(context);

    return ListView(
      children: [
        Hero(
          tag: widget.otherUser.id,
          child: Icon(
            Icons.person,
            size: 128,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Hero(
          tag: widget.otherUser.username,
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  widget.otherUser.name,
                  textScaleFactor: 2.5,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("I will be a ..."),
              Row(
                children: [
                  Radio(
                    groupValue: _role,
                    value: Role.mentor,
                    onChanged: (value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                  Text("Mentor"),
                  Radio(
                    groupValue: _role,
                    value: Role.mentee,
                    onChanged: (value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                  Text("Mentee"),
                ],
              ),
              Row(
                children: [
                  Text("End date: "),
                  Text(_endDate.toDateString()),
                  IconButton(
                    onPressed: () async {
                      Toast.show("juhu", context);
                      var initialDate = DateTime.now();

                      DateTime newlySelectedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            DateTime(initialDate.year, initialDate.month, initialDate.day + 29),
                        firstDate:
                            DateTime(initialDate.year, initialDate.month, initialDate.day + 29),
                        lastDate:
                            DateTime(initialDate.year, initialDate.month, initialDate.day + 168),
                      );
                      if(newlySelectedDate != null){
                        setState(() {
                          _endDate = newlySelectedDate;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_today),
                  ),
                ],
              ),
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: "Notes",
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: RaisedButton(
                    child: Text(
                      "Send Request".toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () async {
                      showProgressIndicator(context);
                      int mentorId = widget.otherUser.id;
                      int menteeId = widget.currentUser.id;
                      if (_role == Role.mentor) {
                        mentorId = widget.currentUser.id;
                        menteeId = widget.otherUser.id;
                      } else if (_role == Role.mentee) {
                        mentorId = widget.otherUser.id;
                        menteeId = widget.currentUser.id;
                      }

                      RelationRequest relationRequest = RelationRequest(
                        mentorId: mentorId,
                        menteeId: menteeId,
                        notes: _notesController.text,
                        endDate: _endDate.toTimestamp(),
                      );

                      bloc.add(RelationRequestSent(relationRequest));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
