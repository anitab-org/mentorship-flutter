import 'dart:io';

import 'package:logging/logging.dart';
import 'package:mentorship_client/failure.dart';
import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/home_stats.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/responses/custom_response.dart';

/// Repository for accessing various data about users. Its main task is to serve as an abstraction
/// layer over [UserService]. [UserRepository] exposes following actions:
/// - getting [HomeStats] for the current [User]
/// - getting a list of verified [User]s
/// - getting current [User]
/// - getting particular [User] by their id
/// - updating current [User]s profile
class UserRepository {
  static final UserRepository instance = UserRepository._internal();

  UserRepository._internal();

  Future<HomeStats> getHomeStats() async {
    try {
      final response = await ApiManager.instance.userService.getHomeStats();

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
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
        Logger.root.severe("Error: ${response.error}");
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

  /// Returns current user profile
  Future<User> getCurrentUser() async {
    try {
      final response = await ApiManager.instance.userService.getCurrentUser();

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      User user = User.fromJson(response.body);

      return user;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    }
  }

  /// Returns user profile with the specified id
  Future<User> getUser(int userId) async {
    try {
      final response = await ApiManager.instance.userService.getUser(userId);

      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      User user = User.fromJson(response.body);

      return user;
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    }
  }

  /// Updates current user's profile
  Future<CustomResponse> updateUser(User user) async {
    try {
      final response = await ApiManager.instance.userService.updateUser(user);
      if (!response.isSuccessful) {
        Logger.root.severe("Error: ${response.error}");
        throw Failure.fromJson(response.error);
      }
      return CustomResponse.fromJson(response.body);
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("HttpException");
    }
  }
}
