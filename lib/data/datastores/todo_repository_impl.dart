import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../entities/todo.dart';
import '../entities/todos.dart';
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
  Stream<Todos> listTodos({@required String meId}) {
    return _firestore
        .collection('todos')
        .where('auth_id', isEqualTo: meId)
        .orderBy('position', descending: true)
        .snapshots()
        .asyncExpand<Todos>((event) async* {
      final todoList = event.docs.map((d) {
        return Todo(
          id: d.id,
          title: d['title'] as String,
          completed: d['completed'] as bool,
          position: d['position'] as double,
        );
      }).toList();

      final uncompletedItems =
          todoList.where((item) => !item.completed).toList();
      final completedItems = todoList.where((item) => item.completed).toList();

      yield Todos(
          uncompletedItems: uncompletedItems, completedItems: completedItems);
    });
  }

  @override
  Future<void> createTodo({String meId, String title, double position}) async {
    await _firestore.collection('todos').add(<String, dynamic>{
      'auth_id': meId,
      'title': title,
      'completed': false,
      'position': position
    });
  }

  @override
  Future<void> updateTodo(
      {String id, String title, bool completed, double position}) async {
    final queryMap = <String, dynamic>{};

    if (title != null && title.isNotEmpty) {
      queryMap['title'] = title;
    }
    if (completed != null) {
      queryMap['completed'] = completed;
    }
    if (position != null) {
      queryMap['position'] = position;
    }

    await _firestore.collection('todos').doc(id).update(queryMap);
  }

  @override
  Future<void> deleteTodo({String id}) async {
    await _firestore.collection('todos').doc(id).delete();
  }
}
