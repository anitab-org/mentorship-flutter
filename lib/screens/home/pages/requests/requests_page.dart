import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/extensions/datetime.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/screens/home/pages/requests/bloc/bloc.dart';
import 'package:mentorship_client/screens/request_detail/request_detail.dart';
import 'package:mentorship_client/widgets/bold_text.dart';
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
                pendingRelations.length == 0
                    ? NoRequestsInfo(message: "You don't have any pending mentorship requests.")
                    : _buildRequestsTab(context, pendingRelations),
                pastRelations.length == 0
                    ? NoRequestsInfo(
                        message: "You don't have any past mentorship requests.",
                      )
                    : _buildRequestsTab(context, pastRelations),
                allRelations.length == 0
                    ? NoRequestsInfo(message: "You don't have any mentorship requests.")
                    : _buildRequestsTab(context, allRelations),
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

        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RequestDetailScreen(relation: relation),
            ),
          ),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldText("Mentor: ", relation.mentor.name),
                          BoldText("Mentee: ", relation.mentee.name),
                          BoldText("End date: ", endDate.toDateString()),
                        ],
                      ),
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
                BoldText("Notes: ", relation.notes),
                Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NoRequestsInfo extends StatelessWidget {
  final String message;
  const NoRequestsInfo({this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
