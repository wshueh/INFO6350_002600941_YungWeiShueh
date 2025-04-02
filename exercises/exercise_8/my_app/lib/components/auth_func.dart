import 'package:flutter/material.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({super.key, required this.loggedIn, required this.signOut});

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    if (loggedIn) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('RSVP confirmed.'),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: signOut,
            child: const Text('Logout'),
          ),
        ],
      );
    } else {
      return const Text('Please sign in to RSVP');
    }
  }
}
