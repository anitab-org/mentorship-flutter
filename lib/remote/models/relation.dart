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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['action_user_id'] = this.actionUserId;
    data['sent_by_me'] = this.sentByMe;
    data['mentor'] = this.mentor;
    data['mentee'] = this.mentee;
    data['creation_date'] = this.sentOn;
    data['accept_date'] = this.acceptedOn;
    data['start_date'] = this.startsOn;
    data['end_date'] = this.endsOn;
    data['state'] = this.state;
    data['notes'] = this.notes;
    return data;
  }

  static List<Relation> relations(List<dynamic> relationList) {
    List<Relation> relations = [];
    for (dynamic relationsJson in relationList) {
      relations.add(Relation.fromJson(relationsJson));
    }
    return relations;
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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
