import 'package:flutter/material.dart';
import '../../common_widgets/cuntom_textfield.dart';
import '../../common_widgets/custom_button.dart';

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
        leading: const Icon(Icons.arrow_back_ios, size: 16),
        backgroundColor: blueColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Customer Card ---
            buildCustomerCard(blueColor),
            const SizedBox(height: 20),

            // --- Delivery Requests Heading ---
            const Text(
              "Delivery Requests (02)",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            buildProductCard(blueColor),
            const SizedBox(height: 10),
            buildProductCard(blueColor),
            const SizedBox(height: 20),

            // --- Toggle Switch ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mark as Undelivered",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                Switch(
                  value: isUndelivered,
                  onChanged: (v) {
                    setState(() {
                      isUndelivered = v;
                    });
                  },
                  activeColor: blueColor,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
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
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        focusColor: blueColor,
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

                    const Text(
                      "Select Next Delivery Date",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: selectDate,
                      child: // 🔹 Date of Birth
                      CustomAnimatedTextField(
                        controller: dobController,
                        focusNode: dobFocus,
                        labelText: "Select Next Delivery Date",
                        hintText: "DD/MM/YYYY",
                        prefixIcon: Icons.calendar_today_outlined,
                        iconColor: blueColor,
                        borderColor: blueColor,
                        textColor: Colors.black87,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // --- Date Picker Field ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: blueColor, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                  color: blueColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  selectedDate != null
                                      ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                                      : "Select date",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_drop_down, color: blueColor),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 25),
            // --- Confirm Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                text: "Confirm",
                backgroundColor: isUndelivered ? blueColor : Colors.white,
                borderColor: isUndelivered ? blueColor : blueColor,
                textColor: isUndelivered ? Colors.white : blueColor,
                onPressed: isUndelivered
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Confirmed as Undelivered!"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on_outlined, color: blueColor, size: 17),
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
            children: [
              Icon(Icons.inventory_2_outlined, color: blueColor, size: 17),
              SizedBox(width: 6),
              Text(
                "Product - 02",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.attach_money, color: blueColor, size: 17),
              SizedBox(width: 6),
              Text(
                "Price - \$52.01",
                style: TextStyle(fontSize: 13, color: Colors.grey),
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
        ],
      ),
    );
  }
}
