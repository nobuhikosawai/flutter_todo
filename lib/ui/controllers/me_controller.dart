import 'package:flutter/foundation.dart';
import 'package:flutter_example/data/providers/me_repository_provider.dart';
import 'package:flutter_example/data/repositories/me_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../data/entities/me.dart';

final meProvider = StateNotifierProvider((ref) => MeController(ref));

class MeController extends StateNotifier<AsyncValue<Me>> {
  MeController(this._reference) : super(AsyncValue.loading()) {
    _authenticate();
  }

  MeRepository _repository;

  final ProviderReference _reference;

  // ignore: missing_return
  Future<void> _authenticate() {
    _repository ??= _reference.read(meRepositoryProvider);
    _repository.getMe().listen((me) {
      state = AsyncValue.data(me);
    });
  }

  Future<void> signIn(
      {@required String email, @required String password}) async {
    _repository ??= _reference.read<MeRepository>(meRepositoryProvider);
    final me = await _repository.signIn(email: email, password: password);
    state = AsyncValue.data(me);
  }
}
