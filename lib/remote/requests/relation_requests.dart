class RelationRequest {
  final int mentorId;
  final int menteeId;
  final String notes;
  final double endDate;

  RelationRequest({this.mentorId, this.menteeId, this.notes, this.endDate});

  factory RelationRequest.fromJson(Map<String, dynamic> json) => RelationRequest(
    mentorId: json["mentor_id"],
    menteeId: json["mentee_id"],
    notes: json["notes"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mentor_id'] = this.mentorId;
    data['mentee_id'] = this.menteeId;
    data['notes'] = this.notes;
    data['end_date'] = this.endDate;
    return data;
  }
}