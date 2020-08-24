import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/models/task.dart';
import 'package:mentorship_client/remote/repositories/comment_repository.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/remote/repositories/task_repository.dart';
import 'package:mentorship_client/screens/comment/bloc/bloc.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class CommentsPage extends StatefulWidget {
  final Relation relation;
  final Task task;
  CommentsPage({this.task, this.relation});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
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
                Duration(milliseconds: 300),
                () => _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                ),
              );
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.08),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.comments.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Column(
                            children: [
                              widget.relation.actionUserId == state.comments[i].userId
                                  ? Text("You")
                                  : Text(widget.relation.mentor.name),
                              Text(state.comments[i].comment),
                            ],
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
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                        child: TextField(
                          decoration: InputDecoration(hintText: "Enter your response."),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}

//  BlocBuilder<CommentPageBloc, CommentPageState>(
//           builder: (context, state) {
//             if (state is CommentPageSuccess) {
//               return Container(
//                 child: Text(relation.mentor.id.toString()),
//               );
//             }
//             return LoadingIndicator();
//           },
//         ),
