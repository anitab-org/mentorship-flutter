/// This class represents all data necessary to create a custom response
/// [message] represents a message
class CustomResponse {
  final String message;

  CustomResponse(this.message);

  factory CustomResponse.fromJson(Map<String, dynamic> json) => CustomResponse(json["message"]);
}
