import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F5FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff2C64E3),
        centerTitle: true,
        title: const Text(
          "Summary",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔵 TOP SUMMARY CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TOP COUNTS ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _summaryItem("234", "Total Orders"),
                      _verticalDivider(),
                      _summaryItem("01", "Completed"),
                      _verticalDivider(),
                      _summaryItem("0", "Failed"),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // FUTURE ORDERS
                  Row(
                    children: const [
                      Text(
                        "Future Orders  ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "13",
                        style: TextStyle(
                          color: Color(0xff2C64E3),
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 💳 COLLECTION CARD
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _collectionRow("Case Collected", "\$145"),
                  _divider(),
                  _collectionRow("Digital Payment Collected", "\$0"),
                  _divider(),
                  _collectionRow("POS Collected", "\$0"),
                  _divider(),
                  _collectionRow("Mswipe Collected", "\$0"),
                ],
              ),
            ),
          ],
        ),
      ),

      
    );
  }

  // ----------------------- WIDGETS -----------------------

  Widget _summaryItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        )
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 28,
      color: Colors.grey.shade300,
    );
  }

  Widget _collectionRow(String text, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xff2C64E3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 1,
      height: 4,
    );
  }
}

