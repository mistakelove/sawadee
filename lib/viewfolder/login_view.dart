import 'package:a/constant/routes.dart';

import 'package:a/service/auth/auth_exception.dart';
import 'package:a/service/auth/auth_service.dart';
import 'package:a/utillity-/showerrordialog.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devlogs show log;

class loginview extends StatefulWidget {
  const loginview({super.key});

  @override
  State<loginview> createState() => _loginviewState();
}

// ignore: camel_case_types
class _loginviewState extends State<loginview> {
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
        title: const Text('login'),
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
                await AuthService.firebase().login(
                  email: email,
                  password: password,
                );

                final user = AuthService.firebase().currentuser;
                if (user?.isemailverified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    noteRote,
                    (route) => false,
                  );
                } else {
                  //user.email not verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyRoute,
                    (route) => false,
                  );
                }
              } on userNotFoundAuthException {
                await showErrordialog(
                  context,
                  'user-not-found',
                );
              } on WrongPasswordAuthException {
                await showErrordialog(
                  context,
                  'wrong-password',
                );
              } on genaricAuthException {
                await showErrordialog(
                  context,
                  'authentication-error',
                );
              }
            },
            child: Text('login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('register here'),
          )
        ],
      ),
    );
  }
}
