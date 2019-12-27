import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/task.dart';
import 'package:mentorship_client/remote/user_repository.dart';
import 'package:mentorship_client/screens/home/pages/stats/bloc/bloc.dart';

/// First page from the left on the HomeScreen. Displays welcome message to the user
/// and provides some information on latest achievements.
class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatsPageBloc>(
      create: (context) =>
          StatsPageBloc(userRepository: UserRepository.instance)..add(StatsPageShowed()),
      child: BlocBuilder<StatsPageBloc, StatsPageState>(builder: (context, state) {
        if (state is StatsPageSuccess) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 0, 24),
                child: Text("Welcome, ${state.homeStats.name}", textScaleFactor: 2),
              ),
              Column(
                children: [
                  _buildRow("Pending Requests", state.homeStats.pendingRequests),
                  _buildRow("Accepted Requests", state.homeStats.acceptedRequests),
                  _buildRow("Rejected Requests", state.homeStats.rejectedRequests),
                  _buildRow("Completed Relations", state.homeStats.completedRelations),
                  for (Task achievement in state.homeStats.achievements)
                    Text(achievement.description),
                ],
              )
            ],
          );
        }
        if (state is StatsPageFailure) {
          return Text(state.message);
        }

        if (state is StatsPageLoading) {
          return CircularProgressIndicator();
        } else
          return Text("an error occurred");
      }),
    );
  }

  Row _buildRow(String text, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Text(count.toString()),
      ],
    );
  }
}
