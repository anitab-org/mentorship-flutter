import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorship_client/remote/models/task.dart';
import 'package:mentorship_client/remote/user_repository.dart';
import 'package:mentorship_client/screens/home/pages/stats/bloc/bloc.dart';

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
              Text("Welcome, ${state.homeStats.name}", textScaleFactor: 3),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pending Requests"),
                      Text(state.homeStats.pendingRequests.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Accepted Requests"),
                      Text(state.homeStats.acceptedRequests.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rejected Requests"),
                      Text(state.homeStats.rejectedRequests.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Completed Relations"),
                      Text(state.homeStats.completedRelations.toString()),
                    ],
                  ),
                  for (Task achievement in state.homeStats.achievements)
                    Text(achievement.description),
                ],
              )
            ],
          );
        }
        if (state is StatsPageFailure) {
          return Text(state.message);
        } else
          return Text("an error occurred");
      }),
    );
  }
}
