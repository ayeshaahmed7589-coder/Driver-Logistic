
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../constants/colors.dart';
import '../my_order_controller.dart';
import 'available_orders_screen.dart';

class ActiveOrdersScreen extends ConsumerWidget {
  const ActiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch My Orders controller
    final myOrdersAsync = ref.watch(myOrdersControllerProvider);

    return myOrdersAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: AppColors.electricTeal,
        ),
      ),
      error: (err, stack) => Center(
        child: Text(
          'Something went wrong:\n$err',
          textAlign: TextAlign.center,
        ),
      ),
      data: (orders) {
        // Filter active orders
        final activeOrders = orders
            .where((o) =>
                o.status == 'assigned' ||
                o.status == 'picked_up' ||
                o.status == 'in_transit' ||
                o.status == 'delivered')
            .toList();

        if (activeOrders.isEmpty) {
          return const Center(
            child: Text(
              "No Active Orders",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            // Refresh orders
            await ref.read(myOrdersControllerProvider.notifier).fetchMyOrders();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: activeOrders.length,
            itemBuilder: (context, index) {
              final order = activeOrders[index];
              return OrderCard(order: order);
            },
          ),
        );
      },
    );
  }
}

