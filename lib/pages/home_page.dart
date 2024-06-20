import 'package:codedev/auth/auth_service.dart';
import 'package:codedev/components/search_field.dart';
import 'package:codedev/components/template_section.dart';
import 'package:codedev/constants.dart';
import 'package:codedev/pages/project_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProjectPage(),
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
          TemplateSection(),
          SizedBox(height: 30.0),
          TemplateSection(),
        ]),
      ),
    );
  }
}
