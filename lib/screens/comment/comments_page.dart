import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/models/task.dart';
import 'package:mentorship_client/remote/repositories/comment_repository.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/repositories/task_repository.dart';
import 'package:mentorship_client/remote/requests/comment_request.dart';
import 'package:mentorship_client/screens/comment/bloc/bloc.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';
import 'package:toast/toast.dart';

class CommentsPage extends StatefulWidget {
  final Relation relation;
  final Task task;
  CommentsPage({this.task, this.relation});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  ScrollController _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return BlocProvider<CommentPageBloc>(
      create: (context) => CommentPageBloc(
        RelationRepository.instance,
        TaskRepository.instance,
        CommentRepository.instance,
      )..add(CommentPageShowed(widget.relation, widget.task.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Comments"),
        ),
        body: BlocBuilder<CommentPageBloc, CommentPageState>(
          builder: (context, state) {
            if (state is CommentPageSuccess) {
              Timer(
                Duration(milliseconds: 0),
                () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent),
              );
              return Stack(
                children: [
                  state.comments.isEmpty
                      ? Center(
                          child: Text("You can add comments about the task here"),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1,
                              bottom: MediaQuery.of(context).size.height * 0.08),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.comments.length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onLongPressStart: (LongPressStartDetails details) {
                                  _showPopupMenu(
                                    context,
                                    details.globalPosition,
                                    _textController,
                                    widget.relation,
                                    widget.task.id,
                                    state.comments[i].id,
                                    state.comments[i].comment,
                                  );
                                },
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          readTimestamp(state.comments[i].creationDate).toString()),
                                      Text(state.comments[i].comment),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: AutoSizeText(
                      "Task: " + widget.task.description,
                      style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.04),
                    ),
                    width: double.infinity,
                    color: Colors.grey[100],
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                        child: TextField(
                          focusNode: focus,
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: "Add your comment.",
                            suffixIcon: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () {
                                  BlocProvider.of<CommentPageBloc>(context)
                                    ..add(
                                      CommentCreated(
                                        widget.relation,
                                        widget.task.id,
                                        CommentRequest(
                                          comment: _textController.text,
                                        ),
                                      ),
                                    );
                                  _textController.clear();
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  Toast.show("Sending...", context, duration: 1);
                                }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is CommentPageFailure) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    RaisedButton(
                      child: Text("Go Back"),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            }
            if (state is CommentPageLoading) {
              return LoadingIndicator();
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}

void _showPopupMenu(context, Offset offset, TextEditingController textEditingController,
    Relation relation, int taskId, int commentId, String comment) async {
  // ignore: close_sinks
  final bloc = BlocProvider.of<CommentPageBloc>(context);

  double left = offset.dx;
  double top = offset.dy;
  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(left, top, 100000, 0),
    items: [
      PopupMenuItem(
        child: MaterialButton(
          elevation: 0,
          child: Text("Delete comment"),
          onPressed: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Delete comment"),
                content: Text("Are you sure you want to delete this comment?"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  FlatButton(
                    child: Text("Delete"),
                    onPressed: () {
                      bloc.add(
                        CommentDeleted(
                          relation,
                          taskId,
                          commentId,
                        ),
                      );
                      Navigator.pop(context);
                      Toast.show("Deleting...", context, duration: 1);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      PopupMenuItem(
        child: MaterialButton(
          elevation: 0,
          child: Text("Edit comment"),
          onPressed: () {
            Navigator.pop(context);
            _showDialog(context, comment, relation, taskId, commentId);
            // FocusScope.of(context).requestFocus(focus);
          },
        ),
      ),
    ],
  );
}

_showDialog(context, String comment, Relation relation, int taskId, int commentId) async {
  TextEditingController editingController = TextEditingController()..text = comment;
  // ignore: close_sinks
  final bloc = BlocProvider.of<CommentPageBloc>(context);
  await showDialog<String>(
    context: context,
    child: AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(labelText: 'Edit comment'),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            }),
        FlatButton(
          child: Text('Edit'),
          onPressed: () {
            bloc.add(
              CommentEditing(
                relation,
                taskId,
                commentId,
                CommentRequest(
                  comment: editingController.text,
                ),
              ),
            );
            Navigator.pop(context);
            Toast.show("Editing...", context, duration: 1);
          },
        )
      ],
    ),
  );
}

String readTimestamp(double timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' day ago';
    } else {
      time = diff.inDays.toString() + ' days ago';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' week ago';
    } else {
      time = (diff.inDays / 7).floor().toString() + ' weeks ago';
    }
  }

  return time;
}
