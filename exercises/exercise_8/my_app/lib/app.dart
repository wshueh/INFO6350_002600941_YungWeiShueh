import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Firebase Auth + GoRouter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
