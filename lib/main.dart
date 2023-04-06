// ignore: unused_import
// ignore_for_file: unused_import, duplicate_ignore, depend_on_referenced_packages, camel_case_types, equal_keys_in_map

import 'package:a/constant/routes.dart';
import 'package:a/service/auth/auth_service.dart';
import 'package:a/viewfolder/REGISTERVIEW.dart';
import 'package:a/viewfolder/login_view.dart';
import 'package:a/viewfolder/note_view.dart';
import 'package:a/viewfolder/verifyemail.dart';
import 'package:flutter/material.dart';
import 'package:a/service/auth/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'sawadee',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Homepage(),
      routes: {
        loginRoute: (context) => const loginview(),
        verifyRoute: (context) => const VerifyEmail(),
        noteRote: (context) => const NoteView(),
        registerRoute: (context) => registerview(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentuser;

            if (user != null) {
              if (user.isemailverified) {
                return const NoteView();
              } else {
                return const VerifyEmail();
              }
            } else {
              return const loginview();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
