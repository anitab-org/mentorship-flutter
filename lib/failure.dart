import 'dart:convert';

class Failure {
  final String message;

  Failure(this.message);

  Failure.fromJson(String jsonString) : message = jsonDecode(jsonString)["message"];

  @override
  String toString() => "Failure: $message";
}
