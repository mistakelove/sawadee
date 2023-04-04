import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class Authuser {
  final bool isemailverified;

  const Authuser(this.isemailverified);

  factory Authuser.fromFirebase(User user) => Authuser(user.emailVerified);
}
