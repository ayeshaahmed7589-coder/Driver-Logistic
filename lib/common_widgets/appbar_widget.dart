import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logisticdriverapp/export.dart';

class BuyerAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const BuyerAppBarWidget({
    super.key,
    required this.controller,
    required this.segmentControlValue,
    required this.segmentCallback,
    required this.tabController,
  });

  final TextEditingController controller;
  final int segmentControlValue;
  final TabController tabController;
  final void Function(int) segmentCallback;

  @override
  Size get preferredSize => const Size.fromHeight(160); // compact height

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: AppBar(
        backgroundColor: AppColors.electricTeal,
        toolbarHeight: preferredSize.height,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Greeting + Notification
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txt: "Hello Jhon",
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  onPressed: () {
                    context.push("/notifications");
                  },
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // TabBar
            SizedBox(
              height: 50, // fixed height to prevent overflow
              child: TabBar(
                controller: tabController,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 4.0, color: Colors.white),
                  insets: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: "Home"),
                  Tab(text: "My Orders"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
