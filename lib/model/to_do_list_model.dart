import 'package:cloud_firestore/cloud_firestore.dart';

Future create(String _title, String _body) async {
  final newList =
      ToDoListData(title: _title, body: _body, time: Timestamp.now());
  await FirebaseFirestore.instance.collection('toDoList').add(newList.toJson());
}

class ToDoListData {
  final String title;
  final String body;
  final Timestamp time;

  const ToDoListData({
    required this.title,
    required this.body,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'time': time,
      };
}
