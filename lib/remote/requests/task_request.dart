import 'package:flutter/cupertino.dart';

class TaskRequest {
  String description;

  TaskRequest({@required this.description});

  factory TaskRequest.fromJson(Map<String, dynamic> json) =>
      TaskRequest(description: json["description"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    return data;
  }
}
