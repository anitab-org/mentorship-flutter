import 'dart:io';

import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/home_stats.dart';
import 'package:mentorship_client/remote/models/user.dart';

class UserRepository {
  static final UserRepository instance = UserRepository._internal();

  UserRepository._internal();

  Future<HomeStats> getHomeStats() async {
    try {
      final response = await ApiManager.instance.userService.getHomeStats();

      if (!response.isSuccessful) {
        print("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      final HomeStats homeStats = HomeStats.fromJson(response.body);

      return homeStats;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    }
  }

  Future<List<User>> getVerifiedUsers() async {
    try {
      final response = await ApiManager.instance.userService.getVerifiedUsers();

      if (!response.isSuccessful) {
        print("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      List<User> users = [];

      for (dynamic userJson in response.body) {
        users.add(User.fromJson(userJson));
      }

      return users;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    }
  }
}
