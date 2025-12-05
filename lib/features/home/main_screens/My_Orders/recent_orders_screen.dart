import 'package:flutter/material.dart';
import 'package:logisticdriverapp/constants/colors.dart';

class RecentOrdersScreen extends StatefulWidget {
  const RecentOrdersScreen({super.key});

  @override
  State<RecentOrdersScreen> createState() => _RecentOrdersScreenState();
}

class _RecentOrdersScreenState extends State<RecentOrdersScreen> {
  // Dummy Recent orders data
  final List<Map<String, String>> recentOrders = [
    {
      'orderId': '001',
      'pickup': 'North Karachi',
      'drop': 'Clifton',
      'earning': '\$18',
      'product': 'Electronics',
      'customer': 'Ali Khan',
    },
    {
      'orderId': '002',
      'pickup': 'Gulshan',
      'drop': 'Tariq Road',
      'earning': '\$12',
      'product': 'Clothing',
      'customer': 'Sara Ahmed',
    },
    {
      'orderId': '003',
      'pickup': 'Korangi',
      'drop': 'DHA Phase 6',
      'earning': '\$22',
      'product': 'Furniture',
      'customer': 'Ahmed Raza',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recentOrders.length,
      itemBuilder: (context, index) {
        final order = recentOrders[index];
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
              // Header row: Order ID + Earning
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order #${order['orderId']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.electricTeal,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.electricTeal.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order['earning'] ?? '',
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
                  const Icon(Icons.local_shipping_outlined,
                      color: AppColors.electricTeal, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Pickup: ${order['pickup']}",
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
                  const Icon(Icons.location_on_outlined,
                      color: AppColors.electricTeal, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Drop: ${order['drop']}",
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
                  const Icon(Icons.shopping_bag_outlined,
                      color: AppColors.electricTeal, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "Product: ${order['product']}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.darkText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Customer
              Row(
                children: [
                  const Icon(Icons.person_outline,
                      color: AppColors.electricTeal, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "Customer: ${order['customer']}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.darkText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Action Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to order details
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
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
