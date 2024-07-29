import 'package:codedev/models/task_model.dart';
import 'package:codedev/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewProjectPage extends StatefulWidget {
  @override
  _NewProjectPageState createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _librariesController = TextEditingController();
  final _deadlineController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _deadlineController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _createProject() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final libraries = _librariesController.text;
    final deadline = _deadlineController.text;

    Task newTask = Task(
      id: "",
      title: title,
      description: description,
      createdAt: DateTime.now(),
      deadline: DateTime.parse(deadline),
      libraries: libraries,
    );

    try {
      await createTask(newTask);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Project created successfully!'),
        ),
      );
      _titleController.clear();
      _descriptionController.clear();
      _librariesController.clear();
      _deadlineController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating project!$e'),
        ),
      );
    }
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
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  _createProject();
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
