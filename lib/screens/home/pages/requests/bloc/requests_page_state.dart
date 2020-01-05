import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/models/relation.dart';

abstract class RequestsPageState extends Equatable {
  final String message;

  const RequestsPageState({this.message});
}

class RequestsPageLoading extends RequestsPageState {
  RequestsPageLoading({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}

class RequestsPageSuccess extends RequestsPageState {
  final List<Relation> relations;

  RequestsPageSuccess(this.relations, {String message}) : super(message: message);

  @override
  List<Object> get props => [message, relations];
}

class RequestsPageFailure extends RequestsPageState {
  RequestsPageFailure({String message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
