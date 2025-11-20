import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logisticdriverapp/common_widgets/appbar_widget.dart';
import 'package:logisticdriverapp/common_widgets/custom_text.dart';
import 'package:logisticdriverapp/constants/colors.dart';
import 'package:logisticdriverapp/features/home/main_screens/completed_screen.dart';
import 'package:logisticdriverapp/features/home/main_screens/future_screen.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({super.key});

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final controller = TextEditingController();
  int segmentValue = 0;
  bool isOnline = true;

  final trips = [
    {
      'name': '23456787643',
      'pickup': '6391 Elgin St. Celina, Delaware 10299',
      'drop': '6391 Elgin St. Celina, Delaware 10299',
      'workOrder': 'View Details',
      'index': '01',
    },
    {
      'name': '23456787643',
      'pickup': '6391 Elgin St. Celina, Delaware 10299',
      'drop': '6391 Elgin St. Celina, Delaware 10299',
      'workOrder': 'View Details',
      'index': '02',
    },
    {
      'name': '23456787643',
      'pickup': '6391 Elgin St. Celina, Delaware 10299',
      'drop': '6391 Elgin St. Celina, Delaware 10299',
      'workOrder': 'View Details',
      'index': '03',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.lightGrayBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.13),
        child: BuyerAppBarWidget(
          controller: controller,
          segmentControlValue: segmentValue,
          segmentCallback: (clickedIndex) {
            setState(() {
              segmentValue = clickedIndex;
              _tabController.animateTo(
                clickedIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            });
          },
          tabController: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildTripsList(), CompletedScreen(), FutureScreen()],
      ),
    );
  }

  Widget _buildTripsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========================= STATUS CARD =========================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lightBorder, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkText.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isOnline ? "You're Online" : "You're Offline",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isOnline ? Colors.green : AppColors.mediumGray,
                    ),
                  ),
                ),
                onlineOfflineToggle(),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ========================= TODAY'S STATS =========================
          const Text(
            "Today’s Stats",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: _buildStatCard("5", "Trips")),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard("\$340", "Earned")),
            ],
          ),

          const SizedBox(height: 20),

          // ========================= TRIPS LIST =========================
          const Text(
            "Active Deliveries",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: trips.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final trip = trips[index];

              return GestureDetector(
                onTap: () {
                  context.go('/order-details');
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.lightBorder, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkText.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name + distance
                      Row(
                        children: [
                          Text(
                            "Order : ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.electricTeal,
                            ),
                          ),
                          Text(
                            trip['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.darkText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // pickup
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping_outlined,
                            color: AppColors.electricTeal,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              trip['pickup']!,
                              style: const TextStyle(
                                color: AppColors.darkText,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.electricTeal,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            trip['drop']!,
                            style: const TextStyle(
                              color: AppColors.mediumGray,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Divider(height: 20, color: AppColors.electricTeal),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 110,
                            height: 28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.electricTeal,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: CustomText(
                              txt: trip['workOrder']!,
                              fontSize: 13,
                              color: AppColors.pureWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.electricTeal,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              trip['index']!,
                              style: const TextStyle(
                                color: AppColors.pureWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget onlineOfflineToggle() {
    const Color activeColor = AppColors.electricTeal;

    return Container(
      width: 70,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.lightBorder, width: 1.4),
      ),
      child: Row(
        children: [
          // OFF BUTTON
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isOnline = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: !isOnline ? activeColor : AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  "OFF",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: !isOnline ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            ),
          ),

          // ON BUTTON
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isOnline = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: isOnline ? activeColor : AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  "ON",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isOnline ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightBorder, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkText.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.electricTeal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppColors.mediumGray),
          ),
        ],
      ),
    );
  }
}
