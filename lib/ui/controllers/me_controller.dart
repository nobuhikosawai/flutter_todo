import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../data/entities/me.dart';
import '../../data/providers/me_repository_provider.dart';
import '../../data/repositories/me_repository.dart';

final meProvider = StateNotifierProvider<MeController, AsyncValue<Me?>>((ref) => MeController(ref));

class MeController extends StateNotifier<AsyncValue<Me?>> {
  MeController(this._reference) : super(AsyncValue.loading()) {
    _authenticate();
  }

  late MeRepository _repository;

  final ProviderReference _reference;

  void _authenticate() {
    _repository = _reference.read(meRepositoryProvider);
    _repository.getMe().listen((me) {
      state = AsyncValue.data(me);
    });
  }

  Future<void> signIn(
      {required String email, required String password}) async {
    _repository = _reference.read<MeRepository>(meRepositoryProvider);
    final me = await _repository.signIn(email: email, password: password);
    state = AsyncValue.data(me);
  }
}
