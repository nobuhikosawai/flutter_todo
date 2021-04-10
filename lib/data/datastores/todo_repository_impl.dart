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

  late FirebaseFirestore _firestore;

  @override
  Stream<Todos> listTodos({required String meId}) {
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
          position: (d['position'] as num).toDouble(),
          // This is a workaround because updatedAt is changed by updateTodo method with
          // ServerTimestamp, updateAt can be null during update.
          // There is a way to use serverTimestampBehavior of SnapshotOptions for
          // other platform such as iOS and android so this should be fix to flutter
          // any time soon. Meanwhile the workaround is used.
          createdAt: d['created_at'] == null
              ? DateTime.now()
              : (d['created_at'] as Timestamp).toDate(),
          updatedAt: d['updated_at'] == null
              ? DateTime.now()
              : (d['updated_at'] as Timestamp).toDate(),
        );
      }).toList();

      final uncompletedItems =
          todoList.where((item) => !item.completed).toList();
      final completedItems = todoList.where((item) => item.completed).toList();

      completedItems.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      yield Todos(
          uncompletedItems: uncompletedItems, completedItems: completedItems);
    });
  }

  @override
  Future<Todo> createTodo(
      {required String meId,
      required String title,
      required double position}) async {
    final ref = await _firestore.collection('todos').add(<String, dynamic>{
      'auth_id': meId,
      'title': title,
      'completed': false,
      'position': position,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
    final data = await ref.get();
    return Todo(
      id: data.id,
      title: data['title'] as String,
      completed: data['completed'] as bool,
      position: data['position'] as double,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  @override
  Future<void> updateTodo(
      {required String id,
      String? title,
      bool? completed,
      double? position}) async {
    final queryMap = <String, dynamic>{};

    if (title == null && completed == null && position == null) {
      throw ArgumentError('Nothing to update');
    }

    queryMap['updated_at'] = FieldValue.serverTimestamp();
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
  Future<void> deleteTodo({required String id}) async {
    await _firestore.collection('todos').doc(id).delete();
  }
}
