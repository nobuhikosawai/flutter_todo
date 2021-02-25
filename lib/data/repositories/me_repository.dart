import 'package:flutter/foundation.dart';

import '../models/me.dart';

abstract class MeRepository {
  Stream<Me> getMe();

  Future<Me> signIn({@required String email, @required String password});
}
