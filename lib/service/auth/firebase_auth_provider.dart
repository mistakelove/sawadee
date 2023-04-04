import 'package:a/service/auth/auth_exception.dart';
import 'package:a/service/auth/auth_provider.dart';
import 'package:a/service/auth/auth_user.dart';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<Authuser> creatUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentuser;
      if (user != null) {
        return user;
      } else {
        throw userNotFoundAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInuseAuthException();
      } else if (e.code == 'Invalid-email') {
        throw InvaildEmailAuthException();
      } else {
        throw genaricAuthException();
      }
    } catch (_) {
      throw genaricAuthException();
    }
  }

  @override
  Authuser? get currentuser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return Authuser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<Authuser> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentuser;
      if (user != null) {
        return user;
      } else {
        throw userNotFoundAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw userNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw genaricAuthException();
      }
    } catch (e) {
      throw genaricAuthException();
    }
  }

  @override
  Future<void> logoout() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseAuth.instance.signOut();
    } else {
      throw userNotFoundAuthException();
    }
  }

  @override
  Future<void> sendemailverification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw userNotFoundAuthException();
    }
  }
}

/*@override
Future<Authuser> login({
  required String email,
  required String password,
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = currentuser;
    if (user != null) {
      return user;
    } else {
      throw userNotFoundAuthException();
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw userNotFoundAuthException();
    } else if (e.code == 'wrong-password') {
      throw WrongPasswordAuthException();
    } else {
      throw genaricAuthException();
    }
  } catch (e) {
    throw genaricAuthException();
  }
}*/

/*@override
Future<void> logoout() async {
  final user = FirebaseAuth.instance.currentUser;
  if(user != null) {
    FirebaseAuth.instance.signOut();
}
else{
  throw userNotFoundAuthException();
}
}*/

/*@override
Future<void> sendemailverification() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await user.sendEmailVerification();
  } else {
    throw userNotFoundAuthException();
  }
}*/

/*@override
Authuser? get currentuser {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return Authuser.fromFirebase(user);
  } else {
    return null;
  }
}*/
