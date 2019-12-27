import 'package:equatable/equatable.dart';

abstract class StatsPageEvent extends Equatable {
  const StatsPageEvent();

  @override
  List<Object> get props => null;
}

class StatsScreenShowed extends StatsPageEvent {}
