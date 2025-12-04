import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../constants/local_storage.dart';
import 'login_modal.dart';
import 'login_repo.dart';

class LoginController extends StateNotifier<AsyncValue<LoginModel?>> {
  final LoginRepository repository;

  LoginController(this.repository) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final result = await repository.login(email: email, password: password);
      await LocalStorage.saveToken(result.data.accessToken);
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<LoginModel?>>((ref) {
  final repo = ref.watch(loginRepositoryProvider);
  return LoginController(repo);
});
