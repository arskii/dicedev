import 'package:codedev/auth/login_or_signup.dart';
import 'package:codedev/pages/home_page.dart';
import 'package:codedev/pages/login_page.dart';
import 'package:codedev/pages/project_page.dart';
import 'package:codedev/pages/register_page.dart';
import 'package:codedev/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: LoginOrSignUp(),
    );
  }
}
