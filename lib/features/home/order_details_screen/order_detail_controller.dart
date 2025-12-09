import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'order_detail_modal.dart';
import 'order_detail_repo.dart';

final orderDetailsControllerProvider =
    StateNotifierProvider.family<OrderDetailsController,
        AsyncValue<OrderModel>, int>((ref, id) {
  final repo = ref.watch(orderRepositoryProvider);
  return OrderDetailsController(repo)..fetchOrderDetails(id);
});

class OrderDetailsController extends StateNotifier<AsyncValue<OrderModel>> {
  final OrderRepository repository;

  OrderDetailsController(this.repository)
      : super(const AsyncValue.loading());

  Future<void> fetchOrderDetails(int id) async {
    state = const AsyncValue.loading();
    try {
      final result = await repository.getOrderDetails(id);
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
