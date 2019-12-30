import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];

  factory HomeEvent.fromIndex(int index) {
    HomeEvent event;
    switch (index) {
      case 0:
        event = StatsPageSelected();
        break;
      case 1:
        event = ProfilePageSelected();
        break;
      case 2:
        event = RelationPageSelected();
        break;
      case 3:
        event = MembersPageSelected();
        break;
      case 4:
        event = RequestsPageSelected();
        break;
      default:
        Logger.root.shout("HomeEvent.fromIndex: index $index is not valid");
    }

    return event;
  }
}

class StatsPageSelected extends HomeEvent {}

class ProfilePageSelected extends HomeEvent {}

class RelationPageSelected extends HomeEvent {}

class MembersPageSelected extends HomeEvent {}

class RequestsPageSelected extends HomeEvent {}
