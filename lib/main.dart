import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MotoLogApp());
}

class MotoLogApp extends StatelessWidget {
  const MotoLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MotoLog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}