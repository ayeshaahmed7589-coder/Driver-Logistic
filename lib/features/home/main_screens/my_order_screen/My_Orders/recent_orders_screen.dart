import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logisticdriverapp/constants/colors.dart';

import '../my_order_controller.dart';
import 'available_orders_screen.dart';
class RecentOrdersScreen extends ConsumerWidget {
  const RecentOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myOrdersAsync = ref.watch(myOrdersControllerProvider);

    return myOrdersAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.electricTeal),
      ),
      error: (err, stack) => Center(
        child: Text(
          'Something went wrong:\n$err',
          textAlign: TextAlign.center,
        ),
      ),
      data: (_) {
        final recentOrders = ref.watch(recentOrdersProvider);

        if (recentOrders.isEmpty) {
          return const Center(
            child: Text(
              "No Recent Orders",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(myOrdersControllerProvider.notifier).fetchMyOrders();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: recentOrders.length,
            itemBuilder: (context, index) {
              final order = recentOrders[index];
              return OrderCard(order: order);
            },
          ),
        );
      },
    );
  }
}
