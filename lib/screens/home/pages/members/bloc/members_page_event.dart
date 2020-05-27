import 'package:equatable/equatable.dart';

abstract class MembersPageEvent extends Equatable {
  const MembersPageEvent();

  @override
  List<Object> get props => [];
}

class MembersPageShowed extends MembersPageEvent {
  final int pageNumber;

  MembersPageShowed(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
