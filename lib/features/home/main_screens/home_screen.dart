// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:logisticdriverapp/common_widgets/appbar_widget.dart';
// import 'package:logisticdriverapp/common_widgets/custom_text.dart';
// import 'package:logisticdriverapp/constants/colors.dart';
// import 'package:logisticdriverapp/features/home/main_screens/completed_screen.dart';
// import 'package:logisticdriverapp/features/home/main_screens/future_screen.dart';

// class CurrentScreen extends StatefulWidget {
//   const CurrentScreen({super.key});

//   @override
//   State<CurrentScreen> createState() => _CurrentScreenState();
// }

// class _CurrentScreenState extends State<CurrentScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final controller = TextEditingController();
//   int segmentValue = 0;
//   bool isOnline = true;

//   final trips = [
//     {
//       'name': '23456787643',
//       'pickup': '6391 Elgin St. Celina, Delaware 10299',
//       'drop': '6391 Elgin St. Celina, Delaware 10299',
//       'workOrder': 'View Details',
//       'index': '01',
//     },
//     {
//       'name': '23456787643',
//       'pickup': '6391 Elgin St. Celina, Delaware 10299',
//       'drop': '6391 Elgin St. Celina, Delaware 10299',
//       'workOrder': 'View Details',
//       'index': '02',
//     },
//     {
//       'name': '23456787643',
//       'pickup': '6391 Elgin St. Celina, Delaware 10299',
//       'drop': '6391 Elgin St. Celina, Delaware 10299',
//       'workOrder': 'View Details',
//       'index': '03',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: AppColors.lightGrayBackground,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(screenHeight * 0.13),
//         child: BuyerAppBarWidget(
//           controller: controller,
//           segmentControlValue: segmentValue,
//           segmentCallback: (clickedIndex) {
//             setState(() {
//               segmentValue = clickedIndex;
//               _tabController.animateTo(
//                 clickedIndex,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             });
//           },
//           tabController: _tabController,
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [_buildTripsList(), CompletedScreen(), FutureScreen()],
//       ),
//     );
//   }

//   Widget _buildTripsList() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ========================= STATUS CARD =========================
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: AppColors.pureWhite,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: AppColors.lightBorder, width: 2),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.darkText.withOpacity(0.05),
//                   blurRadius: 6,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   height: 12,
//                   width: 12,
//                   decoration: BoxDecoration(
//                     color: isOnline ? Colors.green : Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     isOnline ? "You're Online" : "You're Offline",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: isOnline ? Colors.green : AppColors.mediumGray,
//                     ),
//                   ),
//                 ),
//                 onlineOfflineToggle(),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           // ========================= TODAY'S STATS =========================
//           const Text(
//             "Today’s Stats",
//             style: TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.bold,
//               color: AppColors.darkText,
//             ),
//           ),
//           const SizedBox(height: 12),

//           Row(
//             children: [
//               Expanded(child: _buildStatCard("5", "Trips")),
//               const SizedBox(width: 12),
//               Expanded(child: _buildStatCard("\$340", "Earned")),
//             ],
//           ),

//           const SizedBox(height: 20),

//           // ========================= TRIPS LIST =========================
//           const Text(
//             "Active Deliveries",
//             style: TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.bold,
//               color: AppColors.darkText,
//             ),
//           ),
//           const SizedBox(height: 12),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: trips.length,
//             separatorBuilder: (_, __) => const SizedBox(height: 16),
//             itemBuilder: (context, index) {
//               final trip = trips[index];

//               return GestureDetector(
//                 onTap: () {
//                   context.push('/order-details');
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: AppColors.pureWhite,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppColors.lightBorder, width: 2),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.darkText.withOpacity(0.05),
//                         blurRadius: 6,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // name + distance
//                       Row(
//                         children: [
//                           Text(
//                             "Order : ",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.electricTeal,
//                             ),
//                           ),
//                           Text(
//                             trip['name']!,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: AppColors.darkText,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),

//                       // pickup
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.local_shipping_outlined,
//                             color: AppColors.electricTeal,
//                             size: 18,
//                           ),
//                           const SizedBox(width: 6),
//                           Expanded(
//                             child: Text(
//                               trip['pickup']!,
//                               style: const TextStyle(
//                                 color: AppColors.darkText,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),

//                       Row(
//                         children: [
//                           Icon(
//                             Icons.location_on_outlined,
//                             color: AppColors.electricTeal,
//                             size: 18,
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             trip['drop']!,
//                             style: const TextStyle(
//                               color: AppColors.mediumGray,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       const Divider(height: 20, color: AppColors.electricTeal),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 110,
//                             height: 28,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: AppColors.electricTeal,
//                               borderRadius: BorderRadius.circular(2),
//                             ),
//                             child: CustomText(
//                               txt: trip['workOrder']!,
//                               fontSize: 13,
//                               color: AppColors.pureWhite,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Container(
//                             width: 35,
//                             height: 35,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: AppColors.electricTeal,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Text(
//                               trip['index']!,
//                               style: const TextStyle(
//                                 color: AppColors.pureWhite,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget onlineOfflineToggle() {
//     const Color activeColor = AppColors.electricTeal;

//     return Container(
//       width: 70,
//       height: 28,
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(color: AppColors.lightBorder, width: 1.4),
//       ),
//       child: Row(
//         children: [
//           // OFF BUTTON
//           Expanded(
//             child: GestureDetector(
//               onTap: () => setState(() => isOnline = false),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 250),
//                 decoration: BoxDecoration(
//                   color: !isOnline ? activeColor : AppColors.pureWhite,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   "OFF",
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: !isOnline ? Colors.white : Colors.black54,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // ON BUTTON
//           Expanded(
//             child: GestureDetector(
//               onTap: () => setState(() => isOnline = true),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 250),
//                 decoration: BoxDecoration(
//                   color: isOnline ? activeColor : AppColors.pureWhite,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   "ON",
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: isOnline ? Colors.white : Colors.black54,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatCard(String value, String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 18),
//       decoration: BoxDecoration(
//         color: AppColors.pureWhite,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.lightBorder, width: 2),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.darkText.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: AppColors.electricTeal,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: const TextStyle(fontSize: 14, color: AppColors.mediumGray),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logisticdriverapp/common_widgets/appbar_widget.dart';
import 'package:logisticdriverapp/constants/colors.dart';
import 'package:logisticdriverapp/features/home/main_screens/my_order_screen.dart';

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

  int selectedOrderTab = 0; // 0 = active, 1 = available, 2 = recent

  // Dummy UI Data (backend ke baghair)
  final List activeOrdersUI = [
    {"pickup": "North Karachi", "drop": "Clifton", "earning": "\$18"},
    {"pickup": "Gulshan", "drop": "Tariq Road", "earning": "\$12"},
    {"pickup": "Korangi", "drop": "DHA Phase 6", "earning": "\$22"},
    {"pickup": "Nazimabad", "drop": "Seaview", "earning": "\$16"},
  ];

  final List availableOrdersUI = [
    {"pickup": "Saddar", "drop": "Malir Cantt", "earning": "\$25"},
    {"pickup": "Shah Faisal", "drop": "Gulshan 13D", "earning": "\$14"},
    {"pickup": "Orangi", "drop": "Johar Block 15", "earning": "\$20"},
  ];

  final List recentOrdersUI = [
    {"pickup": "Bahadurabad", "drop": "NIPA", "earning": "\$10"},
    {"pickup": "FB Area", "drop": "Clifton", "earning": "\$21"},
  ];

  final List<String> orderTabs = ["Active Orders", "Available Orders","Recent Orders"];

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
        children: [
          _buildTripsList(),
          const MyOrderScreen(),
        ],
      ),
    );
  }

  Widget _buildTripsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========================= DRIVER HEADER CARD =========================
          Container(
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
              children: [
                // avatar
                _profileWithStatusDot(isOnline),
                const SizedBox(width: 12),
                // name / rating / vehicle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Jhon",
                        style: const TextStyle(
                          color: AppColors.pureWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.pureWhite.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: AppColors.pureWhite,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "4.8",
                                  style: TextStyle(
                                    color: AppColors.pureWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.pureWhite.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.local_shipping_outlined,
                                  size: 14,
                                  color: AppColors.pureWhite,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Van · KHI-1234",
                                  style: TextStyle(color: AppColors.pureWhite),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Online toggle (rounded)
                _onlineToggleCompact(),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ========================= TODAY'S STATS =========================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Today’s Stats",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
              ),
              // small label
              Text(
                "Updated now",
                style: TextStyle(color: AppColors.mediumGray, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCardWithIcon(
                  "5",
                  "Trips",
                  Icons.directions_car,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCardWithIcon(
                  "\$340",
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
                  "\$4,200",
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
                  "245",
                  "Completed",
                  Icons.check_circle,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ========================= ACTIVE DELIVERIES TITLE + DROPDOWN =========================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderTabs[selectedOrderTab], // ← selected ke according title change
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
          ),

          const SizedBox(height: 12),

          // ========================= ORDER LIST (ONLY TOP 3 ITEMS) =========================
          Builder(
            builder: (context) {
              List listToShow = [];

              if (selectedOrderTab == 0) {
                listToShow = activeOrdersUI;
              } else if (selectedOrderTab == 1) {
                listToShow = availableOrdersUI;
              } else {
                listToShow = recentOrdersUI;
              }

              // sirf top 3 show
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

                  return _buildTripCard({
                    "pickup": trip["pickup"],
                    "drop": trip["drop"],
                    "earning": trip["earning"],
                    "index": "${index + 1}",
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _onlineToggleCompact() {
    return Switch(
      value: isOnline,

      activeColor: AppColors.electricTeal,
      activeTrackColor: AppColors.lightGrayBackground,
      inactiveTrackColor: AppColors.lightGrayBackground,
      inactiveThumbColor: AppColors.electricTeal,
      onChanged: (v) => setState(() => isOnline = v),
    );
  }

  Widget _profileWithStatusDot(bool isOnline) {
    return Stack(
      children: [
        // Profile Image
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

        // Online / Offline Dot
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: isOnline ? Colors.green : Colors.red,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.pureWhite, // to blend with avatar border
                width: 2,
              ),
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

  Widget _buildTripCard(Map<String, String> trip) {
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
          // header row
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "Order : ",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.electricTeal,
                            ),
                          ),
                          Text(
                            trip['index']!, // FIXED HERE
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.darkText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // earning bubble
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
                  trip['earning'] ?? '',
                  style: const TextStyle(
                    color: AppColors.electricTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // pickup
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.local_shipping_outlined,
                color: AppColors.electricTeal,
                size: 18,
              ),
              const SizedBox(width: 8),
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
          const SizedBox(height: 8),

          // drop
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.electricTeal,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  trip['drop']!,
                  style: const TextStyle(
                    color: AppColors.mediumGray,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 8, color: AppColors.lightBorder),

          const SizedBox(height: 8),
          // actions row
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.push('/order-details'),
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
    );
  }
}
