import 'package:codedev/auth/auth_service.dart';
import 'package:codedev/components/search_field.dart';
import 'package:codedev/components/template_section.dart';
import 'package:codedev/constants.dart';
import 'package:codedev/pages/new_project_page.dart';
import 'package:codedev/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_auth.currentUser == null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/LoginPage", (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.logout))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person_outline)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewProjectPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('New project'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ListView(children: const [
          SearchField(),
          SizedBox(height: 30.0),
          TemplateSection(
            title: 'My Projects',
          ),
        ]),
      ),
    );
  }
}
