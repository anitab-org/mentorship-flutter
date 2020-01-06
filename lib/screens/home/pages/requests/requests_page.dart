import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/extensions/datetime.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/screens/home/pages/requests/bloc/bloc.dart';
import 'package:mentorship_client/screens/request_detail/request_detail.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';

class RequestsPage extends StatefulWidget {
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RequestsPageBloc>(context).add(RequestsPageShowed());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Theme.of(context).accentColor,
          tabs: [
            Tab(text: "Pending".toUpperCase()),
            Tab(text: "Past".toUpperCase()),
            Tab(text: "All".toUpperCase()),
          ],
        ),
        body: BlocBuilder<RequestsPageBloc, RequestsPageState>(builder: (context, state) {
          if (state is RequestsPageSuccess) {
            state.relations.sort((rel1, rel2) => rel2.sentOn.compareTo(rel1.sentOn));

            List<Relation> pendingRelations =
                state.relations.where((rel) => rel.state == 1).toList();
            List<Relation> pastRelations = state.relations.where((rel) => rel.state != 1).toList();
            List<Relation> allRelations = state.relations;

            return TabBarView(
              children: [
                _buildRequestsTab(context, pendingRelations),
                _buildRequestsTab(context, pastRelations),
                _buildRequestsTab(context, allRelations),
              ],
            );
          }

          if (state is RequestsPageFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          return LoadingIndicator();
        }),
      ),
    );
  }

  Widget _buildRequestsTab(BuildContext context, List<Relation> relations) {
    return ListView.builder(
      itemCount: relations.length,
      itemBuilder: (context, index) {
        Relation relation = relations[index];

        DateTime startDate = DateTimeX.fromTimestamp(relation.sentOn);
        DateTime endDate = DateTimeX.fromTimestamp(relation.endsOn);

        return Card(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestDetailScreen(relation: relation),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  tileMode: TileMode.repeated,
                  // Where the linear gradient begins and ends
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  colors: [
                    // Colors are easy thanks to Flutter's Colors class.
                    relation.sentByMe
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                    Colors.white,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mentor: ${relation.mentor.name}"),
                            Text("Mentee: ${relation.mentee.name}"),
                            Text("End date: ${endDate.toDateString()}"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Sent on ${startDate.toDateString()}"),
                            SizedBox(height: 4),
                            if (relation.sentByMe) Text("Sent by me") else Text("To me")
                          ],
                        )
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: "Notes: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: relation.notes),
                        ],
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
