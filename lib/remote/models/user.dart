class User {
  final int id;
  final String username;
  final String name;
  final String slackUsername;
  final String bio;
  final String location;
  final String occupation;
  final String organization;
  final String interests;
  final String skills;
  final bool needsMentoring;
  final bool availableToMentor;

  User(
      {this.id,
      this.username,
      this.name,
      this.slackUsername,
      this.bio,
      this.location,
      this.occupation,
      this.organization,
      this.interests,
      this.skills,
      this.needsMentoring,
      this.availableToMentor});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        name: json['name'],
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
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
