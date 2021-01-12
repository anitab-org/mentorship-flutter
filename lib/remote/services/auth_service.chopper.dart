// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AuthService extends AuthService {
  _$AuthService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthService;

  @override
  Future<Response<Map<String, dynamic>>> login(Login login) {
    final $url = 'login';
    final $body = login;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Object>> register(Register register) {
    final $url = 'register';
    final $body = register;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Object, Object>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> googleSignIn(
      GoogleSignInModel googleSignIn) {
    final $url = 'google/auth/callback';
    final $body = googleSignIn;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
