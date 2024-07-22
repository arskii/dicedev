import 'package:codedev/pages/chat_page.dart';
import 'package:flutter/material.dart';

class NewProjectPage extends StatefulWidget {
  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _librariesController = TextEditingController();
  final _deadlineController = TextEditingController();

  void _createProject() {
    // Handle project creation logic here
    final title = _titleController.text;
    final description = _descriptionController.text;
    final libraries = _librariesController.text;
    final deadline = _deadlineController.text;

    // For now, just print the values
    print('Title: $title');
    print('Description: $description');
    print('Libraries: $libraries');
    print('Deadline: $deadline');

    // Clear the text fields after project creation
    _titleController.clear();
    _descriptionController.clear();
    _librariesController.clear();
    _deadlineController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Project'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _librariesController,
                decoration: InputDecoration(
                  labelText: 'Libraries',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _deadlineController,
                decoration: InputDecoration(
                  labelText: 'Deadline',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                },
                child: Text('Create Project'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
