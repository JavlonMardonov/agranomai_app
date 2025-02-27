import 'package:agranom_ai/presentation/screens/history_screen.dart';
import 'package:agranom_ai/presentation/screens/landing_screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingPage(),
        // '/history': (context) => const ChatHistoryPage(),
      },
    );
  }
}
