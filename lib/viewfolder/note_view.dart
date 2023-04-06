import 'package:a/enum.dart/menu_action.dart';
import 'package:a/service/auth/auth_service.dart';

import 'package:flutter/material.dart';

import '../constant/routes.dart';

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

                  if (shouldlogout) {
                    await AuthService.firebase().logoout();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
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
