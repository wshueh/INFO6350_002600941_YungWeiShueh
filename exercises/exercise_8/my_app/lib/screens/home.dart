import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../components/auth_func.dart';
import '../models/app_state.dart';
import '../components/guest_book.dart';
import '../components/yes_no_selection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Silicon Valley Cat Lovers Meetup"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.go('/profile');
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Image.asset('assets/event_photo.jpg'),
          const SizedBox(height: 8),
          const IconAndDetail(Icons.calendar_today, 'May 30'),
          const IconAndDetail(Icons.location_city, 'San Jose'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () async {
                await FirebaseAuth.instance.signOut();
                context.go('/sign-in');
              },
            ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("What we'll be doing"),
          const Paragraph(
            'Join us for a purr-fect day of cat talk and new feline-loving friends!',
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                switch (appState.attendees) {
                  1 => const Paragraph('1 person going'),
                  >= 2 => Paragraph('${appState.attendees} people going'),
                  _ => const Paragraph('No one going'),
                },
                if (appState.loggedIn) ...[
                  YesNoSelection(
                    state: appState.attending,
                    onSelection: (attending) => appState.attending = attending,
                  ),
                  const SizedBox(height: 16),
                  const Header('Discussion'),
                  GuestBook(
                    addMessage: (message) =>
                        appState.addMessageToGuestBook(message),
                    messages: appState.guestBookMessages,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconAndDetail extends StatelessWidget {
  final IconData icon;
  final String detail;

  const IconAndDetail(this.icon, this.detail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(detail),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String text;

  const Header(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  final String text;

  const Paragraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
