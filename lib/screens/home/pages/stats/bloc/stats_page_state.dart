import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/home_stats.dart';

abstract class StatsPageState extends Equatable {
  const StatsPageState();

  @override
  List<Object> get props => [];
}

class StatsPageInitial extends StatsPageState {}

class StatsPageLoading extends StatsPageState {}

class StatsPageSuccess extends StatsPageState {
  final HomeStats homeStats;

  StatsPageSuccess(this.homeStats);

  @override
  List<Object> get props => [homeStats];
}

class StatsPageFailure extends StatsPageState {
  final String message;

  StatsPageFailure(this.message);

  @override
  List<Object> get props => [message];
}
