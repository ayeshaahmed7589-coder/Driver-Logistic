import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../export.dart';
import 'order_detail_controller.dart';
import 'order_detail_modal.dart';

class OrderDetailsScreen extends ConsumerWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderDetailsControllerProvider(orderId));

    return Scaffold(
      backgroundColor: AppColors.lightGrayBackground,
      appBar: AppBar(
        title: const Text("Order Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.electricTeal,
        foregroundColor: AppColors.pureWhite,
        elevation: 0,
      ),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
        data: (order) => _buildBody(context, ref, order),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, OrderModel order) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          /// -------- STATUS BADGE ----------
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(order.status),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              order.status.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 16),

          _customerCard(order),
          const SizedBox(height: 16),

          _locationCard("Pickup Location", order.pickup),
          const SizedBox(height: 16),

          _locationCard("Delivery Location", order.delivery),
          const SizedBox(height: 16),

          _itemsCard(order),
          const SizedBox(height: 16),

          _addOnsCard(order),
          const SizedBox(height: 16),

          _paymentCard(order),
          const SizedBox(height: 25),

           _actionButtons(context, ref, order),
        ],
      ),
    );
  }

  // ---------------- STATUS COLOR ----------------
  Color _getStatusColor(String status) {
    switch (status) {
      case "pending": return Colors.orange;
      case "assigned": return Colors.blue;
      case "picked_up": return Colors.purple;
      case "in_transit": return Colors.green;
      case "delivered": return Colors.teal;
      default: return Colors.grey;
    }
  }

  // ---------------- CUSTOMER CARD ----------------
  Widget _customerCard(OrderModel order) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.lightBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.electricTeal,
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.customer.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 18, color: AppColors.electricTeal),
                    const SizedBox(width: 6),
                    Text(order.customer.phone,
                        style: const TextStyle(color: AppColors.electricTeal)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // ---------------- LOCATION CARD ----------------
  Widget _locationCard(String title, dynamic loc) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.lightBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: AppColors.electricTeal),
                const SizedBox(width: 6),
                Expanded(
                    child: Text("${loc.address}, ${loc.city}, ${loc.state}",
                        style: const TextStyle(color: AppColors.mediumGray))),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.person_outline, size: 18, color: AppColors.electricTeal),
                const SizedBox(width: 6),
                Text(loc.contactName),
                const SizedBox(width: 16),
                const Icon(Icons.phone_outlined, size: 18, color: AppColors.electricTeal),
                const SizedBox(width: 6),
                Text(loc.contactPhone),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ---------------- ITEMS LIST CARD ----------------
  Widget _itemsCard(OrderModel order) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.lightBorder)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Package Items",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            ...order.items.map((i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.inventory_2_outlined,
                          color: AppColors.electricTeal),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(
                              "${i.productName}  • Qty: ${i.quantity} • Weight: ${i.weightKg}kg")),
                    ],
                  ),
                )),

            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Total Weight: ${order.packageInfo.totalWeight} kg",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  // ---------------- ADD ONS CARD ----------------
  Widget _addOnsCard(OrderModel order) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.lightBorder)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add-Ons",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            ...order.addOns.selected.map(
              (a) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(a.icon, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text("${a.name} — ${a.driverAction}",
                            style: const TextStyle(color: AppColors.darkText))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ---------------- PAYMENT CARD ----------------
  Widget _paymentCard(OrderModel order) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.lightBorder)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Payment Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            _paymentRow("Estimated Cost", order.payment.estimatedCost),
            _paymentRow("Service Fee", order.payment.serviceFee),
            _paymentRow("Add-Ons", order.payment.addOnsCost),
            _paymentRow("Tax", order.payment.taxAmount),

            const Divider(height: 20),

            _paymentRow("Driver Earning",
                order.payment.driverEarning.toStringAsFixed(2),
                bold: true),
          ],
        ),
      ),
    );
  }

  Widget _paymentRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.w700 : FontWeight.normal)),
          const Spacer(),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.w700 : FontWeight.normal)),
        ],
      ),
    );
  }
}

Widget _actionButtons(BuildContext context, WidgetRef ref, OrderModel order) {

  Future<void> updateOrderStatus(String newStatus) async {
    ref.refresh(orderDetailsControllerProvider(order.id));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order $newStatus")),
    );

    ref.refresh(orderDetailsControllerProvider(order.id));
  }

  switch (order.status) {
    case "assigned":
      return mainButton("Accept Order", () {
        updateOrderStatus("accepted");
      });

    case "accepted":
      return mainButton("Navigate to Pickup", () {
        context.push("/map-screen", extra: {
          "order": order,
          "type": "pickup",
        });
      });

    case "picked_up":
      return mainButton("Navigate to Delivery", () {
        context.push("/map-screen", extra: {
          "order": order,
          "type": "delivery",
        });
      });

    case "in_transit":
      return mainButton("Mark as Delivered", () {
        updateOrderStatus("delivered");
      });

    default:
      return const SizedBox();
  }
}

Widget mainButton(String text, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.electricTeal,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    ),
  );
}
