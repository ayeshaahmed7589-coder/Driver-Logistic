import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logisticdriverapp/common_widgets/appbar_widget.dart';
import 'package:logisticdriverapp/constants/colors.dart';
import 'package:logisticdriverapp/features/home/main_screens/my_order_screen/my_order_screen.dart';
import 'package:logisticdriverapp/features/home/order_details_screen/order_detail_screen.dart';

import 'home_controller.dart';
import 'home_modal.dart';

class CurrentScreen extends ConsumerStatefulWidget {
  const CurrentScreen({super.key});

  @override
  ConsumerState<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends ConsumerState<CurrentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int segmentValue = 0;
  bool isOnline = true;
  int selectedOrderTab = 0; // 0 = active, 1 = available, 2 = recent
  final TextEditingController controller = TextEditingController();

  final List<String> orderTabs = [
    "Active Orders",
    "Available Orders",
    "Recent Orders",
  ];

  String numToString(dynamic value) {
    if (value == null) return "0";

    if (value is num) return value.toString();

    if (value is String) return num.tryParse(value)?.toString() ?? "0";

    return "0";
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardControllerProvider);

    return dashboardState.when(
      data: (dashboard) => _buildDashboardUI(dashboard!),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, st) =>
          Scaffold(body: Center(child: Text("Error: ${err.toString()}"))),
    );
  }

  Widget _buildDashboardUI(DashboardModel dashboard) {
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
        children: [_buildTripsList(dashboard), const MyOrderScreen()],
      ),
    );
  }

  Widget _buildTripsList(DashboardModel dashboard) {
    // Select orders based on tab
    List<Order> listToShow = [];

    if (selectedOrderTab == 0) {
      // Active order
      if (dashboard.activeOrder != null) {
        listToShow.add(dashboard.activeOrder!);
      }
    } else if (selectedOrderTab == 1) {
      // Available orders
      listToShow = dashboard.availableOrders;
    } else if (selectedOrderTab == 2) {
      // Recent orders -> convert RecentOrder to Order
      listToShow = dashboard.recentOrders.map((r) {
        return Order(
          id: r.id,
          orderNumber: r.orderNumber,
          status: '', // Recent orders status is not needed
          customerName: '', // Not needed
          customerPhone: '', // Not needed
          pickupAddress: '', // Not needed
          deliveryAddress: r.deliveryAddress,
          packageDescription: null,
          distanceKm: null,
          estimatedEarning: r.earning,
          pickupLatitude: null,
          pickupLongitude: null,
          deliveryLatitude: null,
          deliveryLongitude: null,
          createdAt: r.completedAt,
        );
      }).toList();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDriverHeaderCard(),
          const SizedBox(height: 20),
          _buildStats(dashboard.stats),
          const SizedBox(height: 20),
          _buildOrderTabDropdown(),
          const SizedBox(height: 12),
          _buildOrderList(listToShow),
        ],
      ),
    );
  }

  Widget _buildDriverHeaderCard() {
    return Consumer(
      builder: (context, ref, _) {
        final dashboardAsync = ref.watch(dashboardControllerProvider);

        return dashboardAsync.when(
          data: (dashboard) {
            final driver = dashboard?.driverInfo;
            if (driver == null) return const SizedBox();

            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.electricTeal.withOpacity(0.95),
                    AppColors.electricTeal,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkText.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profileWithStatusDot(
                    driver.status == "available",
                  ), // ✅ reactive dot
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, ${driver.name}",
                          style: const TextStyle(
                            color: AppColors.pureWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _infoBubble(
                              icon: Icons.star,
                              label: driver.rating.toString(),
                              isWhite: true,
                            ),
                            _infoBubble(
                              icon: Icons.local_shipping_outlined,
                              label:
                                  "${driver.vehicle?.vehicleType ?? '-'} · ${driver.vehicle?.registrationNumber ?? '-'}",
                              isWhite: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: _onlineToggleCompact(), // ✅ reactive Switch
                  ),
                ],
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const SizedBox(),
        );
      },
    );
  }

  Widget _infoBubble({
    required IconData icon,
    required String label,
    bool isWhite = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: isWhite ? AppColors.pureWhite.withOpacity(0.12) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: isWhite ? AppColors.pureWhite : null),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isWhite ? AppColors.pureWhite : null,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(Stats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            Expanded(
              child: _buildStatCardWithIcon(
                numToString(stats.today.orders),
                "Trips",
                Icons.directions_car,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCardWithIcon(
                "\$${stats.today.earnings.toString()}",
                "Earned",
                Icons.attach_money,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Weekly Earning",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCardWithIcon(
                "\$${numToString(stats.week.earnings)}",
                "Week",
                Icons.calendar_today,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Total Trips",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCardWithIcon(
                stats.total.completedOrders.toString(),
                "Completed",
                Icons.check_circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderTabDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          orderTabs[selectedOrderTab],
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.darkText,
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: const [
              DropdownMenuItem(value: 0, child: Text("Active Orders")),
              DropdownMenuItem(value: 1, child: Text("Available Orders")),
              DropdownMenuItem(value: 2, child: Text("Recent Orders")),
            ],
            onChanged: (value) {
              setState(() {
                selectedOrderTab = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderList(List<Order> listToShow) {
    final limitedList = listToShow.take(3).toList();

    if (limitedList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          "No orders available",
          style: TextStyle(color: AppColors.mediumGray),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: limitedList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final trip = limitedList[index];
        return _buildTripCard(trip);
      },
    );
  }

  Widget _onlineToggleCompact() {
    return Consumer(
      builder: (context, ref, _) {
        final controller = ref.read(dashboardControllerProvider.notifier);
        final dashboardAsync = ref.watch(dashboardControllerProvider);

        return dashboardAsync.when(
          data: (dashboard) {
            final driver = dashboard?.driverInfo;
            if (driver == null) return const SizedBox();

            final isOnline = driver.status == "available";

            return Row(
              children: [
                Switch(
                  value: isOnline,
                  activeColor: AppColors.electricTeal,
                  activeTrackColor: AppColors.lightGrayBackground,
                  inactiveTrackColor: AppColors.lightGrayBackground,
                  inactiveThumbColor: AppColors.electricTeal,
                  onChanged: controller.isUpdatingStatus
                      ? null
                      : (value) async {
                          try {
                            final status = await controller.toggleAvailability(
                              value,
                            );

                            if (kDebugMode) {
                              print("status: $status");
                            }
                          } catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
                          }
                        },
                ),
                const SizedBox(width: 8),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const SizedBox(),
        );
      },
    );
  }

  Widget _profileWithStatusDot(bool isOnline) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.pureWhite,
          child: CircleAvatar(
            radius: 25,
            backgroundImage: const NetworkImage(
              'https://i.pravatar.cc/150?img=12',
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: isOnline ? Colors.green : Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.pureWhite, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCardWithIcon(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightBorder, width: 1.6),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkText.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.electricTeal.withOpacity(0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.electricTeal, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.electricTeal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.mediumGray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



// main cards
  Widget _buildTripCard(Order trip) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightBorder, width: 1.6),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkText.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Order Number + Earning
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order: ${trip.orderNumber}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.electricTeal,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.electricTeal.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "\$${trip.estimatedEarning?.toStringAsFixed(2) ?? '0'}",
                  style: const TextStyle(
                    color: AppColors.electricTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Pickup Address
          if ((trip.pickupAddress) != '')
            Row(
              children: [
                const Icon(
                  Icons.local_shipping_outlined,
                  color: AppColors.electricTeal,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    trip.pickupAddress,
                    style: const TextStyle(
                      color: AppColors.darkText,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          if ((trip.pickupAddress) != '') const SizedBox(height: 8),

          // Drop Address
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.electricTeal,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  trip.deliveryAddress,
                  style: const TextStyle(
                    color: AppColors.mediumGray,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Distance & Date
          Row(
            children: [
              const Icon(
                Icons.straighten,
                color: AppColors.electricTeal,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                trip.distanceKm ?? '-',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.calendar_today,
                color: AppColors.electricTeal,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(trip.createdAt ?? '-', style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 8, color: AppColors.lightBorder),
          const SizedBox(height: 8),

          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailsScreen(orderId: trip.id),
                      ),
                    );
                    // orderId is already an int
                    // context.push('/order-details', extra: trip.id);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.pureWhite,
                    backgroundColor: AppColors.electricTeal,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "View Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
             
              ),
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.electricTeal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  trip.id.toString(),
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
    );
  }
}
