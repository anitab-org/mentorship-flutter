/// Represents all the information related to a user of the system
class User {
  int id;
  String username;
  String name;
  String email;
  String slackUsername;
  String bio;
  String location;
  String occupation;
  String organization;
  String interests;
  String skills;
  bool needsMentoring;
  bool availableToMentor;

  User(
      {this.id,
      this.username,
      this.name,
      this.email,
      this.slackUsername,
      this.bio,
      this.location,
      this.occupation,
      this.organization,
      this.interests,
      this.skills,
      this.needsMentoring,
      this.availableToMentor});

  /// Returns info about user's availability to be a mentor and a mentee
  String requestStatus() {
    if (needsMentoring && availableToMentor) {
      return "Available to mentor and to be a mentee.";
    } else if (needsMentoring) {
      return "Needs mentoring";
    } else if (availableToMentor) {
      return "Available to mentor";
    } else
      return "";
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        name: json['name'],
        email: json['email'],
        slackUsername: json['slack_username'],
        bio: json['bio'],
        location: json['location'],
        occupation: json['occupation'],
        organization: json['organization'],
        interests: json['interests'],
        skills: json['skills'],
        needsMentoring: json['need_mentoring'],
        availableToMentor: json['available_to_mentor'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['slack_username'] = this.slackUsername;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['occupation'] = this.occupation;
    data['organization'] = this.organization;
    data['interests'] = this.interests;
    data['skills'] = this.skills;
    data['need_mentoring'] = this.needsMentoring;
    data['available_to_mentor'] = this.availableToMentor;
    return data;
  }
}
