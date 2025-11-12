import 'package:flutter/material.dart';

import '../../common_widgets/custom_button.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color blueColor = Color(0xFF004DEB);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 35,
        leading: Icon(Icons.arrow_back_ios,size: 16,),
        backgroundColor: blueColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Customer Card ---
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Top Row ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "John Doe",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: blueColor,
                        ),
                      ),
                      Text(
                        "Dist: 14 mi",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: blueColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // --- Address ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.location_on_outlined,
                        color: blueColor,
                        size: 17,
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "6391 Elgin St. Celina, Delaware 10299",
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ),
                      Icon(Icons.directions, color: blueColor),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(
                        Icons.inventory_2_outlined,
                        color: blueColor,
                        size: 17,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Product - 02",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.attach_money, color: blueColor, size: 17),
                      SizedBox(width: 6),
                      Text(
                        "Price - \$52.01",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 10),
                  // --- Call Button ---
                  Row(
                    children: const [
                      Icon(Icons.phone_outlined, color: blueColor, size: 20),
                      SizedBox(width: 6),
                      Text(
                        "Call Customer",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: blueColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- Delivery Requests ---
            const Text(
              "Delivery Requests (02)",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // --- Product Cards ---
            buildProductCard(blueColor),
            const SizedBox(height: 10),
            buildProductCard(blueColor),

            const SizedBox(height: 20),

            // --- Mark Undelivered + Confirm ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mark as Undelivered",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                Switch(value: false, onChanged: (v) {}, activeColor: blueColor),
              ],
            ),
            const SizedBox(height: 20),

            // --- Confirm Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                text: "Confirm",
                backgroundColor: blueColor,
                borderColor: blueColor,
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Product Card Widget ---
  Widget buildProductCard(Color blueColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "FMPP189153529",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    // Scan Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.qr_code_scanner, size: 17),
                      label: const Text("Scan"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "RIGO Men Jump Printed Terry Joggers",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Qty: 01 | Price: \$52.01",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF004DEB),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
