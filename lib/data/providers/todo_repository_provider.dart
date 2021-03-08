import 'package:riverpod/riverpod.dart';

import '../datastores/todo_repository_impl.dart';

final todoRepositoryProvider = Provider((ref) => TodoRepositoryImpl());
