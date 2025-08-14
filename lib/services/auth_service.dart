class AuthService {
  static const _demoEmail = 'lazqii@gmail.com';
  static const _demoPassword = '123456789';

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return email == _demoEmail && password == _demoPassword;
  }
}
