// ignore_for_file: unused_local_variable

import 'package:a/service/auth/auth_exception.dart';
import 'package:a/service/auth/auth_provider.dart';
import 'package:a/service/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () async {
    final provider = MockAuthProvider();
    test("should not be initialized to be gin wiyh", () {
      expect(provider._isinitialized, false);
    });
    test('cannot log out if not initialzed', () {
      expect(provider.logoout(), throwsA(TypeMatcher<notinitialzedexception>));
    });

    test('should be able to be initialzed', () async {
      await provider.initialize();
      expect(provider.isinitialized, true);
    });

    test('user null', () async {
      expect(provider.currentuser, null);
    });

    test('be able initialize ', () async {
      await provider.initialize();
      expect(provider._isinitialized, true);
    },
        timeout: const Timeout(
          Duration(seconds: 2),
        ));
    test('create use shold delegate to login', () async {
      final bademailuser =
          provider.creatUser(email: 'foolbar@.com', password: "123456za");
      expect(bademailuser, throwsA(TypeMatcher<userNotFoundAuthException>));
    });
    final badpassworduser =
        provider.creatUser(email: 'somebar@.com', password: '123456za');
    expect(badpassworduser, throwsA(TypeMatcher<WrongPasswordAuthException>));
    final user = await provider.creatUser(email: 'foo', password: 'bar');
    expect(provider.currentuser, user);
    expect(user.isemailverified, false);

    test('log in vorify', () {
      provider.sendemailverification();
      final user = provider.currentuser;
      expect(user, isNotNull);
      expect(user!.isemailverified, true);
    });
    test('log out vorify', () async {
      await provider.logoout();
      await provider.login(email: 'user', password: 'password');
    });
    final User = provider.currentuser;
    expect(user, isNotNull);
  });
}

class notinitialzedexception implements Exception {}

class MockAuthProvider implements AuthProvider {
  Authuser? _user;
  var _isinitialized = false;
  bool get isinitialized => _isinitialized;

  @override
  Future<Authuser> creatUser({
    required String email,
    required String password,
  }) async {
    if (!isinitialized) throw notinitialzedexception();
    await Future.delayed(Duration(seconds: 1));
    return login(email: email, password: password);
  }

  @override
  // TODO: implement currentuser
  Authuser? get currentuser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(Duration(seconds: 1));
    _isinitialized = true;
  }

  @override
  Future<Authuser> login({
    required String email,
    required String password,
  }) {
    if (!isinitialized) throw notinitialzedexception();
    if (email == "foolbar@.com") throw userNotFoundAuthException();
    if (password == "123456za") throw WrongPasswordAuthException();
    const user = Authuser(isemailverified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logoout() async {
    if (!isinitialized) throw notinitialzedexception();
    if (_user == null) throw userNotFoundAuthException();
    await Future.delayed(Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendemailverification() async {
    if (!isinitialized) throw notinitialzedexception();
    final user = _user;
    if (user == null) throw userNotFoundAuthException();
    const newUser = Authuser(isemailverified: true);
    _user = newUser;
  }
}
