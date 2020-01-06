import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/extensions/context.dart';
import 'package:mentorship_client/extensions/datetime.dart';
import 'package:mentorship_client/screens/home/bloc/bloc.dart';
import 'package:mentorship_client/screens/home/pages/relation/bloc/bloc.dart';
import 'package:mentorship_client/widgets/bold_text.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';
import 'package:toast/toast.dart';

class RelationPage extends StatefulWidget {
  @override
  _RelationPageState createState() => _RelationPageState();
}

// TODO: Use BLOC to make state management more robust

class _RelationPageState extends State<RelationPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RelationPageBloc>(context).add(RelationPageShowed());

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
        body: BlocListener<RelationPageBloc, RelationPageState>(
          listener: (context, state) {
            if (state.message != null) {
              context.showSnackBar(state.message);
            }
          },
          child: BlocBuilder<RelationPageBloc, RelationPageState>(
            builder: (context, state) {
              if (state is RelationPageSuccess) {
                return TabBarView(
                  children: [
                    _buildDetailsTab(context, state),
                    _buildTasksTab(context, state),
                  ],
                );
              }

              if (state is RelationPageFailure) {
                return Center(
                  child: Text(state.message),
                );
              }

              return LoadingIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return BlocBuilder<RelationPageBloc, RelationPageState>(
      builder: (context, state) {
        bool visible = false;

        if (state is RelationPageSuccess) {
          visible = (state.relation != null);
        }

        return AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: Duration(milliseconds: 500),
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => Toast.show("Not implemented yet", context),
          ),
        );
      },
    );
  }

  Widget _buildDetailsTab(BuildContext context, RelationPageState state) {
    if (state is RelationPageSuccess) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText("Mentor: ", state.relation.mentor.name),
                  BoldText("Mentee: ", state.relation.mentee.name),
                  BoldText(
                      "End date: ", DateTimeX.fromTimestamp(state.relation.endsOn).toDateString()),
                  BoldText("Notes: ", state.relation.notes),
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text("Cancel".toUpperCase(), style: TextStyle(color: Colors.white)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Cancel Relation"),
                    content: Text("Are you sure you want to cancel the relation"),
                    actions: [
                      FlatButton(
                        child: Text("Yes"),
                        onPressed: () {
                          BlocProvider.of<RelationPageBloc>(context)
                              .add(RelationPageCancelledRelation(state.relation.id));
                        },
                      ),
                      FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      );
    }

    if (state is RelationPageFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.message),
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
    }

    return LoadingIndicator();
  }

  Widget _buildTasksTab(BuildContext context, RelationPageState state) {
    if (state is RelationPageSuccess) {
      return Scaffold(
        floatingActionButton: _buildFab(context),
        body: Builder(
          builder: (context) {
            if (state.tasks.length == 0) {
              return Center(
                child: Text("There are no tasks"),
              );
            }

            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Checkbox(
                          onChanged: (value) {},
                          value: state.tasks[index].isDone,
                        ),
                        Text(state.tasks[index].description),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      );
    }

    if (state is RelationPageFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.message),
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
    }

    return LoadingIndicator();
  }
}
