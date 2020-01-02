class Relation {
  final int id;
  final int actionUserId;
  final bool sentByMe;
  final RelationUserResponse mentor;
  final RelationUserResponse mentee;
  final double sentOn;
  final double acceptedOn;
  final double startsOn;
  final double endsOn;
  final int state;
  final String notes;

  Relation({
    this.id,
    this.actionUserId,
    this.sentByMe,
    this.mentor,
    this.mentee,
    this.sentOn,
    this.acceptedOn,
    this.startsOn,
    this.endsOn,
    this.state,
    this.notes,
  });

  factory Relation.fromJson(Map<String, dynamic> json) {
    return Relation(
      id: json["id"],
      actionUserId: json["action_user_id"],
      sentByMe: json["sent_by_me"],
      mentor: RelationUserResponse.fromJson(json["mentor"]),
      mentee: RelationUserResponse.fromJson(json["mentee"]),
      sentOn: json["creation_date"],
      acceptedOn: json["accept_date"],
      startsOn: json["start_date"],
      endsOn: json["end_date"],
      state: json["state"],
      notes: json["notes"],
    );
  }
}

/// This data class represents partial information of user of the system.
/// This is used in APIs not directly related with Users, such as in responses
/// related to MentorshipRelation.
class RelationUserResponse {
  final int id;
  final String name;

  RelationUserResponse({this.id, this.name});

  factory RelationUserResponse.fromJson(Map<String, dynamic> json) => RelationUserResponse(
        id: json["id"],
        name: json["name"],
      );
}
