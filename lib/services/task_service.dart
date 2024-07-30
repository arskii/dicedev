import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:codedev/models/task_model.dart';

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

Future<List<Task>> getTasks() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String uid = user.uid;
    CollectionReference userTasks = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("tasks");

    try {
      QuerySnapshot querySnapshot = await userTasks.get();
      List<Task> tasks = querySnapshot.docs.map((doc) {
        return Task.fromFirestore(doc);
      }).toList();

      return tasks;
    } catch (e) {
      print("Error getting tasks: $e");
      return [];
    }
  } else {
    print("User not authenticated");
    return [];
  }
}
