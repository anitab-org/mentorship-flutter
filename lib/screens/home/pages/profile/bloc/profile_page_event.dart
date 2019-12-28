import 'package:equatable/equatable.dart';

abstract class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object> get props => null;
}

class ProfilePageShowed extends ProfilePageEvent {}

class ProfilePageEditClicked extends ProfilePageEvent {}