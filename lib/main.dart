import 'package:codedev/auth/auth_gate.dart';
import 'package:codedev/firebase_options.dart';
import 'package:codedev/pages/chat_page.dart';
import 'package:codedev/pages/home_page.dart';
import 'package:codedev/pages/login_page.dart';
import 'package:codedev/pages/new_project_page.dart';
import 'package:codedev/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: AuthGate(),
      routes: {
        '/LoginPage': (context) => LoginPage(
              onTap: () {},
            ),
        '/HomePage': (context) => const HomePage(),
      },
    );
  }
}
