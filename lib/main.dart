
import 'package:flutter/material.dart';
import 'splash.dart';
import 'screens/login.dart'; // Impor file login.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(), // Sekarang LoginScreen sudah diimpor
      },
    );
  }
}
