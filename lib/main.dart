// ignore: unused_import
// ignore_for_file: unused_import, duplicate_ignore, depend_on_referenced_packages

import 'package:a/viewfolder/REGISTERVIEW.dart';
import 'package:a/viewfolder/login_view.dart';
import 'package:a/viewfolder/verifyemail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'sawadee',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Homepage(),
      routes: {
        '/login': (context) => const loginview(),
        '/register': (context) => const registerview(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print('email verified');
              } else {
                return const VerifyEmail();
              }
            } else {
              return const loginview();
            }

            return const Text("Done");

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
