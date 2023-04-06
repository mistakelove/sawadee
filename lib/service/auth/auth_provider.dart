import 'package:a/service/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  Authuser? get currentuser;
  Future<Authuser> login({
    required String email,
    required String password,
  });
  Future<Authuser> creatUser({
    required String email,
    required String password,
  });
  Future<void> logoout();
  Future<void> sendemailverification();
}
