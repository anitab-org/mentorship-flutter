import 'package:mentorship_client/remote/api_manager.dart';
import 'package:mentorship_client/remote/models/home_stats.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/requests/change_password.dart';
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

  /// Returns home statistics for the current user
  Future<HomeStats> getHomeStats() async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.userService.getHomeStats());
    return HomeStats.fromJson(body);
  }

  /// Returns all users with email verified
  Future<List<User>> getVerifiedUsers() async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.userService.getVerifiedUsers());
    List<User> users = [];

    for (var user in body) {
      users.add(User.fromJson(user));
    }

    return users;
  }

  /// Returns current user profile
  Future<User> getCurrentUser() async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.userService.getCurrentUser());
    return User.fromJson(body);
  }

  /// Returns user profile with the specified id
  Future<User> getUser(int userId) async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.userService.getUser(userId));
    return User.fromJson(body);
  }

  /// Updates current user's profile
  Future<CustomResponse> updateUser(User user) async {
    final body = await ApiManager.callSafely(
        () => ApiManager.instance.userService.updateUser(user));
    return CustomResponse.fromJson(body);
  }

  Future<CustomResponse> changePassword(ChangePassword changePassword) async {
    final body = await ApiManager.callSafely(
            () => ApiManager.instance.userService.changePassword(changePassword));
    return CustomResponse.fromJson(body);
  }
}
