import 'package:riverpod/riverpod.dart';

import '../datastores/me_repository_impl.dart';

final meRepositoryProvider = Provider((ref) => MeRepositoryImpl());
