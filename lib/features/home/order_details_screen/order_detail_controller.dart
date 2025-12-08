import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'order_detail_modal.dart';
import 'order_detail_repo.dart';

final orderDetailsControllerProvider =
    StateNotifierProvider.family<
      OrderDetailsController,
      AsyncValue<OrderModel>,
      int
    >((ref, id) {
      final repo = ref.watch(orderRepositoryProvider);
      return OrderDetailsController(repo)..fetchOrderDetails(id);
    });

class OrderDetailsController extends StateNotifier<AsyncValue<OrderModel>> {
  final OrderRepository repository;

  OrderDetailsController(this.repository) : super(const AsyncValue.loading());

  Future<void> fetchOrderDetails(int id) async {
  state = const AsyncValue.loading();
  try {
    final result = await repository.getOrderDetails(id); // yeh kya return karta hai dekho
    if (kDebugMode) {
      print("Repository returned: $result");
    }

    // Agar result Map<String, dynamic> hai
    if (result is Map<String, dynamic>) {
      final order = OrderModel.fromJson(result as Map<String, dynamic>);
      if (kDebugMode) {
        print("Order ID: ${order.id}");
      }
      print("Number of items: ${order.items.length}");
      state = AsyncValue.data(order);
    } else {
      // Agar repository already OrderModel return kar raha hai
      print("Already OrderModel");
      state = AsyncValue.data(result);
    }
  } catch (e, st) {
    if (kDebugMode) {
      print("ERROR: $e");
    }
    if (kDebugMode) {
      print(st);
    }
    state = AsyncValue.error(e, st);
  }
}


}
