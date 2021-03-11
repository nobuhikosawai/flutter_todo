import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/todo.dart';
import '../repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  TodoRepositoryImpl() {
    _firestore = FirebaseFirestore.instance;
    final host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2:8080'
        : 'localhost:8080';
    _firestore.settings = Settings(host: host, sslEnabled: false);
  }

  FirebaseFirestore _firestore;

  @override
  Stream<List<Todo>> listTodos({@required String meId}) {
    return _firestore
        .collection('todos')
        .where('auth_id', isEqualTo: meId)
        .snapshots()
        .asyncExpand<List<Todo>>((event) async* {
      yield event.docs.map((d) {
        return Todo(
            id: d.id,
            title: d['title'] as String,
            completed: d['completed'] as bool);
      }).toList();
    });
  }

  @override
  Future<void> createTodo({String meId, String title}) async {
    await _firestore.collection('todos').add(
        <String, dynamic>{'auth_id': meId, 'title': title, 'completed': false});
  }
}
