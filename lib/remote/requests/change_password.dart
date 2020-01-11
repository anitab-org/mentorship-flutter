class ChangePassword {
  final String currentPassword;
  final String newPassword;

  ChangePassword({this.currentPassword, this.newPassword});

  factory ChangePassword.fromJson(Map<String, dynamic> json) {
    return ChangePassword(
      currentPassword: json["current_password"],
      newPassword: json["new_password"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map <String, dynamic>();
    data["current_password"] = this.currentPassword;
    data["new_password"] = this.newPassword;
    return data;
  }
}
