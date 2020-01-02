import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/relation.dart';
import 'package:mentorship_client/remote/repositories/relation_repository.dart';
import 'package:mentorship_client/screens/home/bloc/bloc.dart';

class RelationPage extends StatefulWidget {
  @override
  _RelationPageState createState() => _RelationPageState();
}

// TODO: Use BLOC to make state management more robust

class _RelationPageState extends State<RelationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Theme.of(context).accentColor,
          tabs: [
            Tab(text: "Details".toUpperCase()),
            Tab(text: "Tasks".toUpperCase()),
          ],
        ),
        body: TabBarView(
          children: [
            _buildDetailsTab(context),
            Center(
              child: Text("coming soon"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: FutureBuilder(
        future: RelationRepository.instance.getCurrentRelation(),
        builder: (context, AsyncSnapshot<Relation> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You are not in a relation"),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        Text(
                          "Find members",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () => BlocProvider.of<HomeBloc>(context).add(MembersPageSelected()),
                  )
                ],
              ),
            );

          return Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Text("Mentor: ${snapshot.data.mentor.name}"),
                  Text("Mentee: ${snapshot.data.mentee.name}"),
                  Text(
                      "End date: ${DateTime.fromMillisecondsSinceEpoch(snapshot.data.endsOn.toInt() * 1000).toString()}"),
                  Text("Notes: ${snapshot.data.notes}"),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () => RelationRepository.instance.cancelRelation(snapshot.data.id),
                  child: Text("Cancel".toUpperCase()),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
