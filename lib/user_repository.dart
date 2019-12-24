class UserRepository {
  Future<String> authenticate(String username, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }
}
