import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../export.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "Assigned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrayBackground,
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 45,
        backgroundColor: AppColors.electricTeal,
        foregroundColor: AppColors.pureWhite,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Status Badge ---
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: getStatusColor(orderStatus),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  orderStatus,
                  style: const TextStyle(
                    color: AppColors.pureWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Customer Info Card ---
            buildCustomerCard(),
            const SizedBox(height: 20),

            // --- Pickup Location ---
            buildLocationCard(
              title: "Pickup Location",
              address: "6391 Elgin St. Celina, Delaware 10299",
              contactName: "John Doe",
              contactPhone: "+1 234 567 890",
            ),
            const SizedBox(height: 16),

            // --- Delivery Location ---
            buildLocationCard(
              title: "Delivery Location",
              address: "742 Evergreen Terrace, Springfield",
              contactName: "Jane Smith",
              contactPhone: "+1 987 654 321",
            ),
            const SizedBox(height: 20),

            // --- Package Details ---
            buildPackageCard(),
            const SizedBox(height: 16),

            // --- Payment Details ---
            buildPaymentCard(),
            const SizedBox(height: 30),

            // --- Action Buttons ---
            buildActionButtons(),
          ],
        ),
      ),
    );
  }

  // --- Status Color ---
  Color getStatusColor(String status) {
    switch (status) {
      case "Assigned":
        return Colors.orange;
      case "Accepted":
        return Colors.blue;
      case "Picked Up":
        return Colors.purple;
      case "In Transit":
        return Colors.green;
      case "Delivered":
        return Colors.teal;
      default:
        return AppColors.electricTeal;
    }
  }

  // --- Customer Card ---
  Widget buildCustomerCard() {
    return Card(
      color: AppColors.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.lightBorder, width: 2),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.electricTeal,
              child: Icon(Icons.person, color: AppColors.pureWhite, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "John Doe",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      // Call customer
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.phone_outlined,
                          color: AppColors.electricTeal,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "+1 234 567 890",
                          style: TextStyle(color: AppColors.electricTeal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Location Card ---
  Widget buildLocationCard({
    required String title,
    required String address,
    required String contactName,
    required String contactPhone,
  }) {
    return Card(
      color: AppColors.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.lightBorder, width: 2),
      ),

      elevation: 3,
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
                color: AppColors.darkText,
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
                    address,
                    style: const TextStyle(color: AppColors.mediumGray),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.go("/map");
                  },
                  icon: const Icon(
                    Icons.directions,
                    color: AppColors.electricTeal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 18,
                  color: AppColors.electricTeal,
                ),
                const SizedBox(width: 6),
                Text(contactName),
                const SizedBox(width: 16),
                const Icon(
                  Icons.phone_outlined,
                  size: 18,
                  color: AppColors.electricTeal,
                ),
                const SizedBox(width: 6),
                Text(contactPhone),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Package Details Card ---
  Widget buildPackageCard() {
    return Card(
      color: AppColors.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.lightBorder, width: 2),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Package Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.inventory_2_outlined, color: AppColors.electricTeal),
                SizedBox(width: 8),
                Expanded(child: Text("Men Joggers - Qty: 1, Weight: 0.5 kg")),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: const [
                Icon(Icons.inventory_2_outlined, color: AppColors.electricTeal),
                SizedBox(width: 8),
                Expanded(child: Text("T-Shirt - Qty: 2, Weight: 0.3 kg")),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Total Weight: 1.1 kg",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Payment Details Card ---
  Widget buildPaymentCard() {
    return Card(
      color: AppColors.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.lightBorder, width: 2),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.attach_money, color: AppColors.electricTeal),
                SizedBox(width: 8),
                Text("Delivery Fee: \$5.00"),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: const [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AppColors.electricTeal,
                ),
                SizedBox(width: 8),
                Text("Payout: \$52.01"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Action Buttons ---
  Widget buildActionButtons() {
    List<Widget> buttons = [];

    switch (orderStatus) {
      case "Assigned":
        buttons.addAll([
          Expanded(
            child: CustomButton(
              text: "Accept",
              backgroundColor: AppColors.electricTeal,
              borderColor: AppColors.electricTeal,
              textColor: AppColors.pureWhite,
              onPressed: () => setState(() => orderStatus = "Accepted"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomButton(
              text: "Decline",
              backgroundColor: AppColors.lightGrayBackground,
              borderColor: AppColors.electricTeal,
              textColor: AppColors.electricTeal,
              onPressed: () {},
            ),
          ),
        ]);
        break;

      case "Accepted":
        buttons.add(
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(
                text: "Start Pickup",
                backgroundColor: AppColors.electricTeal,
                borderColor: AppColors.electricTeal,
                textColor: AppColors.pureWhite,
                onPressed: () => setState(() => orderStatus = "Picked Up"),
              ),
            ),
          ),
        );
        break;

      case "Picked Up":
        buttons.add(
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(
                text: "Mark In Transit",
                backgroundColor: AppColors.electricTeal,
                borderColor: AppColors.electricTeal,
                textColor: AppColors.pureWhite,
                onPressed: () => setState(() => orderStatus = "In Transit"),
              ),
            ),
          ),
        );
        break;

      case "In Transit":
        buttons.add(
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(
                text: "Delivery Confirmation",
                backgroundColor: AppColors.electricTeal,
                borderColor: AppColors.electricTeal,
                textColor: AppColors.pureWhite,
                onPressed: () {
                  context.go("/confirm-order");
                },
              ),
            ),
          ),
        );
        break;
    }

    return Row(children: buttons);
  }
}
