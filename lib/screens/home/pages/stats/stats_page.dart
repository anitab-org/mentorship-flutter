import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/task.dart';
import 'package:mentorship_client/screens/home/pages/stats/bloc/bloc.dart';
import 'package:mentorship_client/widgets/loading_indicator.dart';
import 'dart:async';

import 'package:mentorship_client/auth/bloc.dart';

/// First page from the left on the HomeScreen. Displays welcome message to the user
/// and provides some information on latest achievements.
///

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatsPageBloc, StatsPageState>(
      listener: (context, state) {
        if (state is StatsPageShowed) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
        }
      },
      builder: (context, state) {
        return BlocBuilder<StatsPageBloc, StatsPageState>(builder: (context, state) {
          if (state is StatsPageSuccess) {
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<StatsPageBloc>(context).add(
                  StatsPageRefresh(),
                );
                return _refreshCompleter.future;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "Welcome, ${state.homeStats.name}!",
                        textScaleFactor: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: [
                        _buildRow("Pending Requests", state.homeStats.pendingRequests),
                        _buildRow("Accepted Requests", state.homeStats.acceptedRequests),
                        _buildRow("Rejected Requests", state.homeStats.rejectedRequests),
                        _buildRow("Completed Relations", state.homeStats.completedRelations),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 12),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Recent Achievements",
                                style: Theme.of(context).textTheme.headline6,
                              )),
                        ),
                        for (Task achievement in state.homeStats.achievements)
                          Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Checkbox(
                                    value: true,
                                    onChanged: (status) => null,
                                    hoverColor: Theme.of(context).accentColor,
                                  ),
                                  Text(achievement.description),
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          if (state is StatsPageFailure) {
            if (state.message == "The token has expired! Please, login again or refresh it.") {
              Future.delayed(Duration.zero, () => _showTokenExpiredDialog(context));
              return Text(state.message);
            } else {
              return Text(state.message);
            }
          }

          if (state is StatsPageLoading) {
            return LoadingIndicator();
          } else
            return Text("an error occurred");
        });
      },
    );
  }

  Widget _buildRow(String text, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline6.apply(color: Colors.grey[600]),
          ),
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

void _showTokenExpiredDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Token expired"),
        content: Text("Relogin to refresh the jwt token"),
        actions: <Widget>[
          FlatButton(
            child: Text('Relogin'),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(JustLoggedOut());

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
