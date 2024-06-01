import 'package:flutter/material.dart';
import 'package:yuktidea_task_app/screens/startup_screen.dart';
import 'package:yuktidea_task_app/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode,
      home: const StartupScreen(),
    );
  }
}
