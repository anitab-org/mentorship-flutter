import 'package:equatable/equatable.dart';

abstract class StatsPageEvent extends Equatable {
  const StatsPageEvent();

  @override
  List<Object> get props => null;
}

class StatsPageShowed extends StatsPageEvent {}

class StatsPageRefresh extends StatsPageEvent {}
