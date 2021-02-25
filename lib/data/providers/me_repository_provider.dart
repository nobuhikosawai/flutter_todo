import 'package:flutter_example/data/datastores/me_repository_impl.dart';
import 'package:riverpod/riverpod.dart';

final meRepositoryProvider = Provider((ref) => MeRepositoryImpl());
