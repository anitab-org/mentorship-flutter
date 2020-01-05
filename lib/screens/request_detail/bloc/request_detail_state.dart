import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RequestDetailState extends Equatable {
  const RequestDetailState();
}

class InitialRequestDetailState extends RequestDetailState {
  final String message;

  InitialRequestDetailState({@required this.message});

  @override
  List<Object> get props => [message];
}
