import 'package:flutter/cupertino.dart';

class CommentRequest {
  String comment;

  CommentRequest({@required this.comment});

  factory CommentRequest.fromJson(Map<String, dynamic> json) =>
      CommentRequest(comment: json["comment"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    return data;
  }
}
