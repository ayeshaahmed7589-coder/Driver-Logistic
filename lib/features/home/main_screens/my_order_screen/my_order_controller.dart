// lib/providers/order_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'my_order_modal.dart';
import 'my_order_repo.dart';

/// 1️⃣ My Orders Controller
final myOrdersControllerProvider =
    StateNotifierProvider<MyOrdersController, AsyncValue<List<OrderModelDetail>>>((ref) {
  final repo = ref.watch(orderRepositoryProvider);
  return MyOrdersController(repo);
});

class MyOrdersController extends StateNotifier<AsyncValue<List<OrderModelDetail>>> {
  final OrderRepository repository;

  MyOrdersController(this.repository) : super(const AsyncValue.loading()) {
    fetchMyOrders();
  }

  Future<void> fetchMyOrders() async {
    state = const AsyncValue.loading();
    try {
      final orders = await repository.getMyOrders();
      state = AsyncValue.data(orders);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// 2️⃣ Available Orders Controller
final availableOrdersControllerProvider =
    StateNotifierProvider<AvailableOrdersController, AsyncValue<List<OrderModelDetail>>>((ref) {
  final repo = ref.watch(orderRepositoryProvider);
  return AvailableOrdersController(repo);
});

class AvailableOrdersController extends StateNotifier<AsyncValue<List<OrderModelDetail>>> {
  final OrderRepository repository;

  AvailableOrdersController(this.repository) : super(const AsyncValue.loading()) {
    fetchAvailableOrders();
  }

  Future<void> fetchAvailableOrders() async {
    state = const AsyncValue.loading();
    try {
      final orders = await repository.getAvailableOrders();
      state = AsyncValue.data(orders);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// 3️⃣ Filtered Providers
final activeOrdersProvider = Provider<List<OrderModelDetail>>((ref) {
  final myOrdersAsync = ref.watch(myOrdersControllerProvider);
  return myOrdersAsync.maybeWhen(
    data: (orders) => orders
        .where((o) =>
            o.status == 'assigned' ||
            o.status == 'picked_up' ||
            o.status == 'in_transit' ||
            o.status == 'delivered')
        .toList(),
    orElse: () => [],
  );
});

final recentOrdersProvider = Provider<List<OrderModelDetail>>((ref) {
  final myOrdersAsync = ref.watch(myOrdersControllerProvider);
  return myOrdersAsync.maybeWhen(
    data: (orders) => orders.where((o) => o.status == 'completed').toList(),
    orElse: () => [],
  );
});

final filteredAvailableOrdersProvider = Provider<List<OrderModelDetail>>((ref) {
  final availableAsync = ref.watch(availableOrdersControllerProvider);
  return availableAsync.maybeWhen(
    data: (orders) =>
        orders.where((o) => o.status == 'pending' || o.status == 'confirmed').toList(),
    orElse: () => [],
  );
});
