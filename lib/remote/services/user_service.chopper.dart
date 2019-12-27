// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

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
  Future<Response<List>> getVerifiedUsers() {
    final $url = 'users/verified';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List, List>($request);
  }
}
