import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/me.dart';
import '../repositories/me_repository.dart';

class MeRepositoryImpl implements MeRepository {
  @override
  Future<Me> signIn({@required String email, @required String password}) async {
    final auth = FirebaseAuth.instance;
    await auth.useEmulator('http://localhost:9099');

    final userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;

    return Me(id: user.uid, displayName: user.displayName);
  }

  @override
  Stream<Me> getMe() async* {
    final auth = FirebaseAuth.instance;
    await auth.useEmulator('http://localhost:9099');

    final userStream = auth.authStateChanges();

    await for (var user in userStream) {
      yield user != null
          ? Me(id: user.uid, displayName: user.displayName ?? '')
          : null; // cast type
    }
  }
}
