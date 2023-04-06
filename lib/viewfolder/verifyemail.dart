import 'package:a/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devlogs show log;

import '../constant/routes.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('verify-email'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(loginRoute, (route) => false);
          },
          icon: const Icon(Icons.turn_left),
        ),
      ),
      body: Column(
        children: [
          const Text(
            "we'send email to verify your gmail pls verify account",
          ),
          const Text(
            "if you haven t verifying email yet ,press bottom below",
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().currentuser;

              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text("send email verify"),
          ),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logoout();

                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: Text('restart'))
        ],
      ),
    );
  }
}
