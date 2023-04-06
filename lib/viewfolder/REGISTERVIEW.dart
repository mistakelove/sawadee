// ignore_for_file: unused_local_variable

import 'package:a/constant/routes.dart';
import 'package:a/service/auth/auth_exception.dart';
import 'package:a/service/auth/auth_service.dart';
import 'package:a/utillity-/showerrordialog.dart';

import 'package:flutter/material.dart';

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
                await AuthService.firebase()
                    .creatUser(email: email, password: password);
                AuthService.firebase().sendemailverification();
                Navigator.of(context).pushNamed(verifyRoute);
              } on WeakPasswordAuthException {
                await showErrordialog(
                  context,
                  'weak-password',
                ); 
              } on EmailAlreadyInuseAuthException {
                await showErrordialog(
                  context,
                  'email-already-in-use',
                );
              } on InvaildEmailAuthException {
                await showErrordialog(
                  context,
                  'email-already-in-use',
                );
              } on genaricAuthException {
                await showErrordialog(
                  context,
                  'Fail to register',
                );
              }
            },
            child: Text('register'),
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
