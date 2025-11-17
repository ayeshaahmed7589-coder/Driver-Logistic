import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrayBackground,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.electricTeal,
        centerTitle: true,
        title: const Text(
          "Summary",
          style: TextStyle(
            color: AppColors.pureWhite,
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
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightBorder,
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
                          color: AppColors.darkText,
                        ),
                      ),
                      Text(
                        "13",
                        style: TextStyle(
                          color: AppColors.electricTeal,
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
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightBorder,
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
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.darkText,
          ),
        )
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 2,
      height: 32,
      color: AppColors.electricTeal,
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
              color: AppColors.darkText,
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.electricTeal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: AppColors.subtleGray,
      thickness: 2,
      height: 4,
    );
  }
}

