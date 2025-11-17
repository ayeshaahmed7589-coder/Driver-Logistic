import 'package:flutter/material.dart';

import 'package:logisticdriverapp/constants/colors.dart';
import 'package:logisticdriverapp/features/home/order_successful.dart';

import '../../export.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isUndelivered = false;
  DateTime? selectedDate;
  TextEditingController noteController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final FocusNode dobFocus = FocusNode();

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dobController.text =
          "${pickedDate.day.toString().padLeft(2, '0')}/"
          "${pickedDate.month.toString().padLeft(2, '0')}/"
          "${pickedDate.year}";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    dobController.dispose();
    noteController.dispose();
    dobFocus.dispose();
    super.dispose();
  }

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
        leading: IconButton(
          onPressed: () {
            // context.pop();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 18),
        ),
        backgroundColor: AppColors.electricTeal,
        foregroundColor: AppColors.pureWhite,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Customer Card ---
            buildCustomerCard(AppColors.electricTeal),
            const SizedBox(height: 23),

            // --- Delivery Requests Heading ---
            CustomText(
              txt: "Delivery Requests (02)",

              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
            const SizedBox(height: 14),

            buildProductCard(AppColors.electricTeal),
            const SizedBox(height: 18),
            buildProductCard(AppColors.electricTeal),
            const SizedBox(height: 20),

            // --- Toggle Switch ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mark as Undelivered",
                  style: TextStyle(fontSize: 16, color: AppColors.mediumGray),
                ),

                Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      // OFF button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isUndelivered = false),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            decoration: BoxDecoration(
                              color: !isUndelivered
                                  ? AppColors.electricTeal
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "OFF",
                              style: TextStyle(
                                color: !isUndelivered
                                    ? AppColors.pureWhite
                                    : Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ON button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isUndelivered = true),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            decoration: BoxDecoration(
                              color: isUndelivered
                                  ? AppColors.electricTeal
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "ON",
                              style: TextStyle(
                                color: isUndelivered
                                    ? AppColors.pureWhite
                                    : Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // --- Conditional Notes + Date + Confirm ---
            if (isUndelivered) ...[
              const SizedBox(height: 10),

              // --- Add Notes Box ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.darkText.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add Notes",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        color: AppColors.mediumGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        focusColor: AppColors.electricTeal,
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔹 Date of Birth
                    CustomAnimatedTextField(
                      controller: dobController,
                      focusNode: dobFocus,
                      labelText: "Select Next Delivery Date",
                      hintText: "Select Next Delivery Date",
                      prefixIcon: Icons.calendar_today_outlined,
                      iconColor: AppColors.electricTeal,
                      borderColor: AppColors.electricTeal,
                      textColor: AppColors.mediumGray,
                      keyboardType: TextInputType.datetime,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        color: AppColors.electricTeal,
                        onPressed: selectDate,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
            const SizedBox(height: 25),
            // --- Confirm Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                text: "Confirm",
                backgroundColor: isUndelivered
                    ? AppColors.electricTeal
                    : AppColors.pureWhite,
                borderColor: isUndelivered
                    ? AppColors.electricTeal
                    : AppColors.electricTeal,
                textColor: isUndelivered
                    ? AppColors.pureWhite
                    : AppColors.electricTeal,
                onPressed: isUndelivered
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderSuccessful(),
                          ),
                        );
                      }
                    : null, // disables tap when false
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Customer Card Widget ---
  Widget buildCustomerCard(Color blueColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkText.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "John Doe",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.electricTeal,
                ),
              ),
              Text(
                "Dist: 14 mi",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.electricTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.electricTeal,
                size: 17,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  "6391 Elgin St. Celina, Delaware 10299",
                  style: TextStyle(fontSize: 14, color: AppColors.mediumGray),
                ),
              ),
              Icon(Icons.directions, color: AppColors.electricTeal),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                color: AppColors.electricTeal,
                size: 17,
              ),
              SizedBox(width: 6),
              Text(
                "Product - 02",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.attach_money, color: AppColors.electricTeal, size: 17),
              SizedBox(width: 6),
              Text(
                "Price - \$52.01",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 11),
          const Divider(height: 1, color: AppColors.electricTeal),
          const SizedBox(height: 13),
          // --- Call Button ---
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                color: AppColors.electricTeal,
                size: 22,
              ),
              SizedBox(width: 6),
              Text(
                "Call Customer",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.electricTeal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Product Card Widget ---
  Widget buildProductCard(Color blueColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkText.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txt: "FMPP189153529",

                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScanBarCodeScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.qr_code_scanner, size: 22),
                      label: const Text(
                        "Scan",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.pureWhite,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.electricTeal,
                        foregroundColor: AppColors.pureWhite,
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
                  style: TextStyle(fontSize: 15, color: AppColors.darkText),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Qty: 01 | Price: \$52.01",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.electricTeal,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
