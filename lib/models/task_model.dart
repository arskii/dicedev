import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id; // Unique identifier for the task
  final String title;
  final String description;
  final String libraries;
  final DateTime deadline;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadline,
    required this.libraries,
  });

  // Convert Task to a Map for Firestore
  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      deadline: (data['deadline'] as Timestamp).toDate(),
      libraries: data['libraries'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'deadline': Timestamp.fromDate(deadline),
      'libraries': libraries
    };
  }
}
