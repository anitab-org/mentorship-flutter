// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$AuthService extends AuthService {
  _$AuthService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthService;

  @override
  Future<Response<AuthToken>> login(Login login) {
    final $url = 'login';
    final $body = login;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AuthToken, AuthToken>($request);
  }

  @override
  Future<Response<Object>> register(Register register) {
    final $url = 'register';
    final $body = register;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Object, Object>($request);
  }
}
