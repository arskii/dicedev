import 'package:codedev/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:codedev/models/task_model.dart';

class TemplateSection extends StatefulWidget {
  final String title;

  const TemplateSection({super.key, required this.title});

  @override
  _TemplateSectionState createState() => _TemplateSectionState();
}

class _TemplateSectionState extends State<TemplateSection> {
  List<Task> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    List<Task> loadedTasks = await getTasks();
    setState(() {
      tasks = loadedTasks;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 10.0,
        ),
        isLoading
            ? CircularProgressIndicator()
            : tasks.isEmpty
                ? Text('No tasks available')
                : Column(
                    children: tasks
                        .map((task) => TemplateItem(
                              icon: Icons.task,
                              title: task.title,
                              onTap: () {},
                            ))
                        .toList(),
                  ),
      ],
    );
  }
}

class TemplateItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const TemplateItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
        ),
      ),
    );
  }
}
