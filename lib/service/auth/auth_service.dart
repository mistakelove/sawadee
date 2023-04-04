import 'package:a/service/auth/auth_provider.dart';
import 'package:a/service/auth/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService(this.provider);

  @override
  Future<Authuser> creatUser({
    required String email,
    required String password,
  }) =>
      provider.creatUser(email: email, password: password);

  @override
  // TODO: implement currentuser
  Authuser? get currentuser => provider.currentuser;

  @override
  Future<Authuser> login({
    required String email,
    required String password,
  }) =>
      provider.login(email: email, password: password);
  @override
  Future<void> logoout() => provider.logoout();

  @override
  Future<void> sendemailverification() => provider.sendemailverification();
}
