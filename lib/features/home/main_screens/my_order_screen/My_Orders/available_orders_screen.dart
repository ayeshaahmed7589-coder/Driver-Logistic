import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logisticdriverapp/constants/colors.dart';

import '../my_order_controller.dart';
import '../my_order_modal.dart';

class AvailableOrdersScreen extends ConsumerWidget {
  const AvailableOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableOrdersAsync = ref.watch(availableOrdersControllerProvider);

    return availableOrdersAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.electricTeal),
      ),
      error: (err, stack) => Center(
        child: Text('Something went wrong:\n$err', textAlign: TextAlign.center),
      ),
      data: (orders) {
        final filteredOrders = ref.watch(filteredAvailableOrdersProvider);

        if (filteredOrders.isEmpty) {
          return const Center(
            child: Text("No Available Orders", style: TextStyle(fontSize: 16)),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(availableOrdersControllerProvider.notifier)
                .fetchAvailableOrders();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              final order = filteredOrders[index];
              return OrderCard(order: order);
            },
          ),
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModelDetail order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightBorder, width: 1.6),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkText.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Order ID + Earning
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order #${order.ordernumber}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.electricTeal,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.electricTeal.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "\$${order.earning}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.electricTeal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Pickup
          Row(
            children: [
              const Icon(
                Icons.local_shipping_outlined,
                color: AppColors.electricTeal,
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "Pickup: ${order.pickup}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Drop
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.electricTeal,
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "Drop: ${order.drop}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.mediumGray,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Product
          Row(
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.electricTeal,
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "Product: ${order.product}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Customer
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                color: AppColors.electricTeal,
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  "Customer: ${order.customer}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.darkText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Action Button
          ElevatedButton(
            onPressed: () {
              final id = order.orderId;

              if (id == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid order ID")),
                );
                return;
              }

              context.push('/order-details', extra: id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.electricTeal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Center(
              child: Text(
                "View Details",
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
