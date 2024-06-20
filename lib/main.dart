import 'package:codedev/auth/auth_gate.dart';
import 'package:codedev/auth/login_or_signup.dart';
import 'package:codedev/firebase_options.dart';
import 'package:codedev/pages/home_page.dart';
import 'package:codedev/pages/login_page.dart';

import 'package:codedev/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: HomePage(),
      routes: {
        '/LoginPage': (context) => LoginPage(
              onTap: () {},
            ),
        '/HomePage': (context) => const HomePage(),
      },
    );
  }
}
