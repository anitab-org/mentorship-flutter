import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorship_client/extensions/datetime.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/screens/home/pages/requests/bloc/bloc.dart';

class RequestDetailScreen extends StatefulWidget {
  final Relation relation;

  const RequestDetailScreen({Key key, @required this.relation}) : super(key: key);

  @override
  _RequestDetailScreenState createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Relation relation = widget.relation;
    final bool isFromMentee = relation.actionUserId == relation.mentee.id;
    String actionUserRole;
    if (isFromMentee) {
      actionUserRole = "Mentee";
    } else {
      actionUserRole = "Mentor";
    }

    String requestDirection = "From";
    if (relation.sentByMe) {
      requestDirection = "To";
    }

    String otherUserName;
    if (relation.sentByMe) {
      if (isFromMentee) {
        otherUserName = relation.mentor.name;
      } else {
        otherUserName = relation.mentee.name;
      }
    } else {
      if (isFromMentee) {
        otherUserName = relation.mentee.name;
      } else {
        otherUserName = relation.mentor.name;
      }
    }

    DateTime endDate = DateTimeExtensions.fromTimestamp(relation.endsOn);
    String formattedEndDate = DateFormat('dd MMM yyyy').format(endDate);

    String summaryMessage;
    if (relation.sentByMe) {
      summaryMessage = "You want to be $otherUserName's $actionUserRole until $formattedEndDate";
    } else {
      summaryMessage = "$otherUserName wants to be your $actionUserRole until $formattedEndDate";
    }

    String relationStatus;
    switch (relation.state) {
      case 1:
        relationStatus = "Pending";
        break;
      case 2:
        relationStatus = "Accepted";
        break;
      case 3:
        relationStatus = "Rejected";
        break;
      case 4:
        relationStatus = "Cancelled";
        break;
      case 5:
        relationStatus = "Completed";
        break;
    }

    return BlocProvider(
      create: (context) => RequestsPageBloc(relationRepository: RelationRepository.instance),
      child: BlocBuilder<RequestsPageBloc, RequestsPageState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text("Request detail"),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "$requestDirection $otherUserName",
                    textScaleFactor: 2,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                summaryMessage,
                textScaleFactor: 2,
                textAlign: TextAlign.center,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Notes: "),
                      Text(relation.notes),
                    ],
                  ),
                ),
              ),
              if (widget.relation.state == 1) // Pending
                RaisedButton(
                  onPressed: () {
                    RelationRepository.instance.acceptRelation(widget.relation.id);
                  },
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Accept",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              else
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "This relation was $relationStatus",
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
