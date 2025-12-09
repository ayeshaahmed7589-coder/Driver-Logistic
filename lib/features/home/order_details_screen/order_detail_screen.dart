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
        automaticallyImplyLeading: false,
        title: const Text(
          "Order Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
    return Column(
      children: [
        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// STATUS BADGE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _customerCard(order),
                const SizedBox(height: 16),
                _locationCard("Pickup Location", order.pickup, () {
                  context.push(
                    "/map",
                    extra: {"order": order, "type": "pickup"},
                  );
                }),

                _locationCard("Delivery Location", order.delivery, () {
                  context.push(
                    "/map",
                    extra: {"order": order, "type": "delivery"},
                  );
                }),

                const SizedBox(height: 16),
                _packageCard(order),
                const SizedBox(height: 16),
                _orderDetailsCard(order),
                const SizedBox(height: 16),
                _addOnsCard(order),
                const SizedBox(height: 16),
                _paymentCard(order),
                const SizedBox(height: 25),
                _actionButtons(context, ref, order),
              ],
            ),
          ),
        ),

      ],
    );
  }

  // ---------------- STATUS COLOR ----------------
  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "assigned":
        return Colors.blue;
      case "picked_up":
        return Colors.purple;
      case "in_transit":
        return Colors.green;
      case "delivered":
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  // ---------------- CUSTOMER CARD ----------------
  Widget _customerCard(OrderModel order) {
    return Card(
      color: AppColors.pureWhite,
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
                Text(
                  order.customer.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      size: 18,
                      color: AppColors.electricTeal,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      order.customer.phone,
                      style: const TextStyle(color: AppColors.electricTeal),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- LOCATION CARD ----------------
  Widget _locationCard(String title, dynamic loc, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: AppColors.pureWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.lightBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.electricTeal,
                  ),
                  const SizedBox(width: 6),

                  Expanded(
                    child: Text(
                      "${loc.address}, ${loc.city}, ${loc.state}",
                      style: const TextStyle(color: AppColors.darkText),
                    ),
                  ),

                  const Icon(Icons.directions, color: AppColors.electricTeal),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- PACKAGE CARD ----------------
  Widget _packageCard(OrderModel order) {
    final pkg = order.packageInfo;

    return Card(
      color: AppColors.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.lightBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Package Details",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _detailRow(
              Icons.inventory_2_outlined,
              "Total Items",
              "${pkg.totalItems}",
            ),
            const SizedBox(height: 12),

            _detailRow(
              Icons.monitor_weight_outlined,
              "Total Weight",
              "${pkg.totalWeight} kg",
            ),
            const SizedBox(height: 12),

            _detailRow(
              Icons.attach_money,
              "Total Value",
              "\$${pkg.totalValue}",
            ),
            const SizedBox(height: 12),

            if (pkg.description.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.description_outlined,
                    size: 22,
                    color: AppColors.electricTeal,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description : ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pkg.description,
                          style: const TextStyle(
                            color: AppColors.darkText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // ---------------- ORDER DETAILS ----------------
  Widget _orderDetailsCard(OrderModel order) {
    final d = order.orderDetails;

    return Card(
      color: AppColors.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.lightBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Details",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _detailRow(
              Icons.local_shipping_outlined,
              "Service Type",
              d.serviceType,
            ),
            const SizedBox(height: 12),

            _detailRow(
              Icons.directions_car_outlined,
              "Vehicle Type",
              d.vehicleType,
            ),
            const SizedBox(height: 12),

            _detailRow(Icons.flag_outlined, "Priority", d.priority),
            const SizedBox(height: 12),

            _detailRow(Icons.route_outlined, "Distance", "${d.distanceKm} km"),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  /// ---------------- REUSABLE ROW WIDGET ----------------
  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 22, color: AppColors.electricTeal),
        const SizedBox(width: 10),

        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ---------------- ADD ONS CARD ----------------
  Widget _addOnsCard(OrderModel order) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: AppColors.pureWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.lightBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add-Ons",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ...order.addOns.selected.map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(a.icon, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${a.name} — ${a.driverAction}",
                          style: const TextStyle(color: AppColors.darkText),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- PAYMENT CARD ----------------
  Widget _paymentCard(OrderModel order) {
    return Card(
      color: AppColors.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.lightBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _paymentRow("Estimated Cost", order.payment.estimatedCost),
            _paymentRow("Service Fee", order.payment.serviceFee),
            _paymentRow("Add-Ons", order.payment.addOnsCost),
            _paymentRow("Tax", order.payment.taxAmount),

            const Divider(height: 20),

            _paymentRow(
              "Driver Earning",
              order.payment.driverEarning.toStringAsFixed(2),
              bold: true,
            ),
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
          Text(
            title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _actionButtons(BuildContext context, WidgetRef ref, OrderModel order) {
  final status = order.status.toLowerCase().replaceAll(" ", "_");

  Future<void> updateOrderStatus(String newStatus) async {
    // ignore: unused_result
    ref.refresh(orderDetailsControllerProvider(order.id));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Order $newStatus")));

    // ignore: unused_result
    ref.refresh(orderDetailsControllerProvider(order.id));
  }

  switch (status) {
    case "pending":
      return mainButton("Confirm Order", () {
        updateOrderStatus("confirmed");
      });

    case "confirmed":
      return mainButton("Assign Order", () {
        updateOrderStatus("assigned");
      });

    case "assigned":
      return mainButton("Navigate to Pickup", () {
        context.push("/map", extra: {"order": order, "type": "pickup"});
      });

    case "picked_up":
      return mainButton("Navigate to Delivery", () {
        context.push("/map", extra: {"order": order, "type": "delivery"});
      });

    case "in_transit":
      return mainButton("Mark as Delivered", () {
        updateOrderStatus("delivered");
      });

    case "delivered":
      return mainButton("Complete Order", () {
        updateOrderStatus("completed");
      });

    case "completed":
      return const SizedBox(); // No button after completion

    default:
      return const SizedBox(); // fallback
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    ),
  );
}
