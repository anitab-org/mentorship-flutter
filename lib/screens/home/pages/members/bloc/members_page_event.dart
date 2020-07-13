import 'package:equatable/equatable.dart';

abstract class MembersPageEvent extends Equatable {
  const MembersPageEvent();

  @override
  List<Object> get props => [];
}

class MembersPageShowed extends MembersPageEvent {}

class MembersPageRefresh extends MembersPageEvent {}
