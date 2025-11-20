import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color blueColor = AppColors.electricTeal;
    return Scaffold(
      backgroundColor: AppColors.lightGrayBackground,
      appBar: AppBar(
        title: const Text(
          "Earning",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 45,
        // leading: IconButton(
        //   onPressed: () => TripsBottomNavBarScreen(initialIndex: 0),
        //   icon: const Icon(Icons.arrow_back_ios, size: 18),
        // ),
        backgroundColor: blueColor,
        foregroundColor: AppColors.pureWhite,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("This Week"),
            _infoCard(
              icon: Icons.monetization_on_outlined,
              title: "\$1,250.00",
              subtitle: "From 28 deliveries",
            ),
            const SizedBox(height: 20),
            _sectionTitle("Wallet Balance"),
            _walletCard(
              balance: "\$850.00",
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _sectionTitle("Earnings Chart"),
            _chartCard(),
            const SizedBox(height: 20),
            _sectionTitle("Recent Transactions"),
            _transactionCard(
              orderId: "12345",
              date: "Jan 15, 2:30 PM",
              amount: "+ \$45.00",
            ),
            const SizedBox(height: 12),
            _transactionCard(
              orderId: "12344",
              date: "Jan 15, 11:20 AM",
              amount: "+ \$38.00",
            ),
          ],
        ),
      ),
    );
  }
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1E1E1E),
        ),
      ),
    );
  }
  Widget _infoCard({
    required icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Icon( icon ,size: 35,color: AppColors.electricTeal),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 14, color: AppColors.mediumGray)),
            ],
          ),
        ],
      ),
    );
  }
  Widget _walletCard({
    required String balance,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Icon(Icons.chrome_reader_mode_rounded,size: 30,color: AppColors.electricTeal),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(balance,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 4),
                const Text(
                  "Wallet Balance",
                  style: TextStyle(fontSize: 14, color: AppColors.mediumGray),
                ),
              ],
            ),
          ),

          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.electricTeal,
                borderRadius: BorderRadius.circular(30),
                
              ),
              child: const Text(
                "Payout →",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chartCard() {
    return Container(
      height: 180,
      decoration: _cardDecoration(),
      child: const Center(
        child: Text(
          "📊 Bar Chart Placeholder",
          style: TextStyle(color: AppColors.mediumGray),
        ),
      ),
    );
  }

  Widget _transactionCard({
    required String orderId,
    required String date,
    required String amount,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
            "Order #$orderId",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Text(date, style: const TextStyle(color:AppColors.mediumGray)),
          
            ],
          ),
          const SizedBox(height: 6),
          Text(
            amount,
            style: const TextStyle(
              color: AppColors.electricTeal,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------
  // 🎨 CARD DECORATION
  // -----------------------------------------------------
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.pureWhite,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: AppColors.lightBorder, width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
