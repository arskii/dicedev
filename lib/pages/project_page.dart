import 'package:codedev/components/custom_field.dart';
import 'package:codedev/constants.dart';
import 'package:codedev/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a new project"),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
              child: Text('Generate'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            CustomField(
              title: 'Project Name',
            ),
            const SizedBox(height: 30.0),
            CustomField(title: 'Project Description'),
            const SizedBox(height: 30.0),
            CustomField(
                controller: datePickerController,
                title: 'Deadline Time',
                onTap: () => onTapFunction(context: context)),
          ],
        ),
      ),
    );
  }
}

TextEditingController datePickerController = TextEditingController();
onTapFunction({required BuildContext context}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    lastDate: DateTime(2026),
    firstDate: DateTime(2022),
    initialDate: DateTime.now(),
  );
  if (pickedDate == null) return;
  datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
}
