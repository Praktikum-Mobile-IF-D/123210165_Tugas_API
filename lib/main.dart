// main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasapi/pages/login.dart';
import 'package:tugasapi/pages/home.dart'; // Pastikan path import benar

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Inisialisasi untuk memastikan SharedPreferences siap
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn =
      prefs.getBool('isLoggedIn') ?? false; // Cek apakah pengguna telah login
  runApp(MainApp(isLoggedIn: isLoggedIn)); // Oper ke MainApp
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  MainApp({required this.isLoggedIn}); // Terima parameter isLoggedIn

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoggedIn ? HomePage() : LoginPage(), // Tentukan halaman awal
    );
  }
}
