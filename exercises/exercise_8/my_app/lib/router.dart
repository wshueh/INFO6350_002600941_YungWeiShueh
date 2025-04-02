import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'screens/auth_gate.dart';
import 'screens/home.dart';

final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final loggingIn = state.matchedLocation == '/sign-in';

    if (user == null && !loggingIn) {
      return '/sign-in';
    }
    if (user != null && loggingIn) {
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(
        providers: const [],
        actions: [
          SignedOutAction((context) {
            context.go('/sign-in');
          }),
        ],
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset('assets/molly.jpg'),
            ),
          ),
        ],
      ),
    ),
  ],
);
