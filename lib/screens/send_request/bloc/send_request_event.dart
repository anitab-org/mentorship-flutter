import 'package:equatable/equatable.dart';
import 'package:mentorship_client/remote/requests/relation_requests.dart';

abstract class SendRequestEvent extends Equatable {
  const SendRequestEvent();
}

class RelationRequestSent extends SendRequestEvent {
  final RelationRequest request;

  RelationRequestSent(this.request);

  @override
  List<Object> get props => [request];
}
