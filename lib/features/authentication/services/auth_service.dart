class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> createAccount(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
