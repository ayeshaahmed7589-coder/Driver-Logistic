import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'home_modal.dart';
import 'home_repo.dart';

final dashboardControllerProvider = StateNotifierProvider<
    DashboardController, AsyncValue<DashboardModel?>>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return DashboardController(repo);
});


class DashboardController extends StateNotifier<AsyncValue<DashboardModel?>> {
  final DashboardRepository repository;
  bool isUpdatingStatus = false; // track loading

  DashboardController(this.repository) : super(const AsyncValue.loading()) {
    fetch();
  }

  Future<void> fetch() async {
    state = const AsyncValue.loading();
    try {
      final model = await repository.fetchDashboard();
      state = AsyncValue.data(model);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Toggle online/offline
  Future<String> toggleAvailability(bool isOnline) async {
    if (isUpdatingStatus) return state.value?.driverInfo.status ?? "off_duty";

    isUpdatingStatus = true;
    try {
      final newStatus = await repository.updateAvailability(isOnline);

      final current = state.value;
      if (current != null) {
        state = AsyncValue.data(
          current.copyWithStatus(newStatus),
        );
      }
      return newStatus;
    } finally {
      isUpdatingStatus = false;
    }
  }
}
