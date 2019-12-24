import 'package:flutter/foundation.dart';

class Register {
  final String name;
  final String username;
  final String email;
  final String password;
  final bool acceptedTermsAndConditions;
  final bool needsMentoring;
  final bool availableToMentor;

  Register(
      {@required this.name,
      @required this.username,
      @required this.email,
      @required this.password,
      @required this.acceptedTermsAndConditions,
      @required this.needsMentoring,
      @required this.availableToMentor});
}
