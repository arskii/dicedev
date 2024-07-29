import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedev/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createTask(Task task) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String uid = user.uid;
    CollectionReference userTasks = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("tasks");
    try {
      await userTasks.add(task.toMap());
      print("Task created successfully");
    } catch (e) {
      print("Error creating task: $e");
    }
  } else {
    print("User not authenticated");
  }
}
