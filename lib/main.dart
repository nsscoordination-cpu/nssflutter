import 'package:flutter/material.dart';
import 'package:nss/Attendence.dart';
import 'package:nss/EventImages.dart';
import 'package:nss/Events.dart';
import 'package:nss/Home.dart';
import 'package:nss/Login.dart';
import 'package:nss/Notification.dart';
import 'package:nss/Profile.dart';
import 'package:nss/Register.dart';
import 'package:nss/Report.dart';
import 'package:nss/StudentPerformance.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = const Color.fromARGB(255, 99, 98, 171); // Deep Blue
  final Color accentColor = const Color.fromARGB(255, 17, 134, 101);  // Light Blue
  final Color backgroundColor = const Color.fromARGB(255, 193, 182, 214); // Light Gray Background

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login + Home Page Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColor,
          secondary: accentColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      home:LoginPage()
    );
  }
}