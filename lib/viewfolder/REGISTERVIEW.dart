// ignore_for_file: unused_local_variable

import 'package:a/constant/routes.dart';
import 'package:a/utillity-/showerrordialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import 'dart:developer' as devtools show log;

class registerview extends StatefulWidget {
  const registerview({super.key});

  @override
  State<registerview> createState() => _registerviewState();
}

class _registerviewState extends State<registerview> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'enter email'),
            controller: _email,
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'enter password'),
            controller: _password,
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(
                  verifyRoute,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  showErrordialog(
                    context,
                    'weak-password',
                  );
                } else if (e.code == 'email-already-in-use') {
                  showErrordialog(
                    context,
                    'email-already-in-use',
                  );
                } else if (e.code == 'Invalid-email') {
                  showErrordialog(
                    context,
                    'Invalid-emaild',
                  );
                } else {
                  await showErrordialog(
                    context,
                    'eror${e.code}',
                  );
                }
              } catch (e) {
                e.toString();
                await showErrordialog(
                  context,
                  e.toString(),
                );
              }
              final UserCredential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
            },
            child: Text(
              'register',
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text("Already register login here"))
        ],
      ),
    );
  }
}
