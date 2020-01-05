import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/screens/home/pages/requests/bloc/bloc.dart';
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
        body: TabBarView(
          children: [
            _buildPending(context),
            _buildPast(context),
            _buildAll(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPending(BuildContext context) {
    return BlocBuilder<RequestsPageBloc, RequestsPageState>(builder: (context, state) {
      if (state is RequestsPageSuccess) {
        List<Relation> pendingRelations = state.relations.where((rel) => rel.state == 1).toList();

        return ListView.builder(
          itemCount: pendingRelations.length,
          itemBuilder: (context, index) {
            Relation relation = pendingRelations[index];

            return ListTile(
              leading: Column(
                children: [
                  Text("Mentor: ${relation.mentor.name}"),
                  Text("Mentee: ${relation.mentee.name}"),
                ],
              ),
            );
          },
        );
      }

      if (state is RequestsPageFailure) {
        return Center(
          child: Text(state.message),
        );
      }

      return LoadingIndicator();
    });
  }

  Widget _buildPast(BuildContext context) {
    return Center(
      child: Text("Past"),
    );
  }

  Widget _buildAll(BuildContext context) {
    return Center(
      child: Text("All"),
    );
  }
}
