import 'package:flutter/foundation.dart';

/// This data class represents all data necessary to register a new user.
/// [name] represents the name of the new user
/// [username] represents the username of the new user, used for login
/// [email] represents the email of the new user, used for login
/// [password] represents the password of the new user, used for login
/// [acceptedTermsAndConditions] is true if the user checked the terms and conditions checkbox
/// [needsMentoring] is true if the user checked Mentee checkbox
/// [availableToMentor] is true if the user
class Register {
  final String name;
  final String username;
  final String email;
  final String password;
  final bool acceptedTermsAndConditions;
  final bool needsMentoring;
  final bool availableToMentor;

  Register({
    @required this.name,
    @required this.username,
    @required this.email,
    @required this.password,
    @required this.acceptedTermsAndConditions,
    @required this.needsMentoring,
    @required this.availableToMentor,
  })  : assert(name != null),
        assert(username != null),
        assert(email != null),
        assert(password != null),
        assert(acceptedTermsAndConditions != null),
        assert(needsMentoring != null),
        assert(availableToMentor != null);


  // TODO Add toJson()
}
