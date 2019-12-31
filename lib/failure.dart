import 'dart:convert';

/// Represents some failure with a message.
class Failure {
  final String message;

  Failure(this.message);

  Failure.fromJson(String jsonString) : message = jsonDecode(jsonString)["message"];

  @override
  String toString() => "Failure: $message";
}
