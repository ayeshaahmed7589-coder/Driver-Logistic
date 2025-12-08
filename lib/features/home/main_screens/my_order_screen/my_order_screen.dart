import 'package:flutter/material.dart';
import 'package:logisticdriverapp/constants/colors.dart';
import 'package:logisticdriverapp/constants/gap.dart';
import 'package:logisticdriverapp/features/home/main_screens/my_order_screen/My_Orders/active_order_screen.dart';
import 'package:logisticdriverapp/features/home/main_screens/my_order_screen/My_Orders/available_orders_screen.dart';
import 'package:logisticdriverapp/features/home/main_screens/my_order_screen/My_Orders/recent_orders_screen.dart';
import 'package:logisticdriverapp/common_widgets/custom_text.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = const [
    Tab(text: "Active"),
    Tab(text: "Available"),
    Tab(text: "Recent"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapH12,
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomTabBar(
            tabController: _tabController,
            tabs: _tabs,
            color: AppColors.electricTeal,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              ActiveOrdersScreen(),
              AvailableOrdersScreen(),
              RecentOrdersScreen(),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------- CustomTabBar ----------------
class CustomTabBar extends StatefulWidget {
  final Color color;
  final List<int>? disabledTabIndices;
  final TabController tabController;
  final List<Tab> tabs;
  final double width;

  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.width = 300,
    this.color = Colors.black,
    this.disabledTabIndices,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: AppColors.lightGrayBackground,
        border: Border.all(color: AppColors.mediumGray),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: widget.width,
        height: kToolbarHeight - 17.0,
        child: Row(
          children: List.generate(widget.tabs.length, (index) {
            final isDisabled =
                widget.disabledTabIndices?.contains(index) == true;
            final isSelected = widget.tabController.index == index;

            return Expanded(
              child: GestureDetector(
                onTap: isDisabled
                    ? null
                    : () {
                        widget.tabController.animateTo(index);
                      },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.electricTeal
                        : (isDisabled ? Colors.grey.shade300 : Colors.transparent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: CustomText(
                      txt: widget.tabs[index].text ?? '',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.pureWhite
                          : (isDisabled ? Colors.grey.shade600 : widget.color),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
