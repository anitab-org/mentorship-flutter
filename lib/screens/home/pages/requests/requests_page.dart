import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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

        DateTime startDate = DateTime.fromMillisecondsSinceEpoch((relation.sentOn * 1000).toInt());
        DateTime endDate = DateTime.fromMillisecondsSinceEpoch((relation.endsOn * 1000).toInt());

        final formatter = DateFormat('dd MMM yyyy');
        String formattedStartDate = formatter.format(startDate);
        String formattedEndDate = formatter.format(endDate);

        return Card(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestDetailScreen(relation: relation),
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
                          Text("End date: $formattedEndDate"),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Sent on $formattedStartDate"),
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
        );
      },
    );
  }
}
