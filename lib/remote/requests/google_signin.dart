import 'package:flutter/foundation.dart';

/// This data class represents all data necessary to create a login
class GoogleSignInModel {
  final String name;
  final String email;
  final String idToken;

  GoogleSignInModel({@required this.name, @required this.email,@required this.idToken})
      : assert(name != null),
        assert(email != null),
        assert(idToken != null);

  Map<String, String> toJson() => {'name': name, "email": email, "id_token": idToken};
}
