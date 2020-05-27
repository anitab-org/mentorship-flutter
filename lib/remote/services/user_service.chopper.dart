// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$UserService extends UserService {
  _$UserService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UserService;

  @override
  Future<Response<Map<String, dynamic>>> getHomeStats() {
    final $url = 'home';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<List<dynamic>>> getVerifiedUsers(
      {int page, int perPage = 10}) {
    final $url = 'users/verified';
    final $params = <String, dynamic>{'page': page, 'per_page': perPage};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<dynamic>, List<dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getCurrentUser() {
    final $url = 'user';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getUser(int userId) {
    final $url = 'user/$userId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> updateUser(User user) {
    final $url = 'user';
    final $body = user;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> changePassword(
      ChangePassword changePassword) {
    final $url = 'user/change_password';
    final $body = changePassword;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
