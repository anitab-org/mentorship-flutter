import 'package:equatable/equatable.dart';

abstract class RequestsPageEvent extends Equatable {
  const RequestsPageEvent();
}

class RequestsPageShowed extends RequestsPageEvent {
  @override
  List<Object> get props => null;
}
