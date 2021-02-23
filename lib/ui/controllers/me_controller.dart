import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final meProvider = StateNotifierProvider((ref) => MeController(ref));

class MeController extends StateNotifier<AsyncValue<dynamic>> {
  MeController(this._reference) : super(null);

  final ProviderReference _reference;

  Future<void> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    throw UnimplementedError();
    // _repository ??= await _reference.read(meRepositoryProvider.future);
    // return _repository
    //     .signIn(EmailCredential(email: email, password: password))
    //     .then((me) {
    //   state = AsyncValue.data(me);
    // });
  }
}
