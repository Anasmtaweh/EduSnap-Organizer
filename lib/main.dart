// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const EduSnapApp());
}

class EduSnapApp extends StatelessWidget {
  const EduSnapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduSnap Organizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home:  HomePage(),
    );
  }
}
