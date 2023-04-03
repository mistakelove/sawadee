// ignore: unused_import
// ignore_for_file: unused_import, duplicate_ignore, depend_on_referenced_packages, camel_case_types, equal_keys_in_map

import 'package:a/constant/routes.dart';
import 'package:a/viewfolder/REGISTERVIEW.dart';
import 'package:a/viewfolder/login_view.dart';
import 'package:a/viewfolder/verifyemail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devlogs show log;

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
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print(user);
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

enum menuaction { logout }

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton<menuaction>(
            onSelected: (value) async {
              switch (value) {
                case menuaction.logout:
                  final shouldlogout = await showlogout(context);
                  devlogs.log(shouldlogout.toString());
                  if (shouldlogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<menuaction>(
                  value: menuaction.logout,
                  child: Text("logout"),
                ),
              ];
            },
          ),
        ],
      ),
      body: const Text('hello world'),
    );
  }
}

Future<bool> showlogout(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('sing out '),
        content: const Text('ru sure you want to log out'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('log out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
