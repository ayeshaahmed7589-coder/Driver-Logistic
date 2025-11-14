import 'package:flutter/material.dart';
import 'package:logisticdriverapp/common_widgets/appbar_widget.dart';
import 'package:logisticdriverapp/common_widgets/custom_text.dart';
import 'package:logisticdriverapp/features/home/completed_screen.dart';
import 'package:logisticdriverapp/features/home/future_screen.dart';
import 'package:logisticdriverapp/features/home/order_detail_screen.dart';

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

  final trips = [
    {
      'name': 'John Doe',
      'address': '6391 Elgin St. Celina, Delaware 10299',
      'product': 'Product - 02',
      'price': '\$52.01',
      'distance': '14 mi',
      'workOrder': 'WO# 04-1209',
      'index': '01',
    },
    {
      'name': 'John Doe',
      'address': '6391 Elgin St. Celina, Delaware 10299',
      'product': 'Product - 02',
      'price': '\$52.01',
      'distance': '14 mi',
      'workOrder': 'WO# 04-1209',
      'index': '02',
    },
    {
      'name': 'John Doe',
      'address': '6391 Elgin St. Celina, Delaware 10299',
      'product': 'Product - 02',
      'price': '\$52.01',
      'distance': '14 mi',
      'workOrder': 'WO# 04-1209',
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
      backgroundColor: const Color(0xFFF3F6FA),
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
    final Color blueColor = const Color(0xFF345CFF);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsScreen()));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      trip['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blueColor,
                      ),
                    ),
                    Text(
                      "Dist: ${trip['distance']}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1A56DB),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: blueColor, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        trip['address']!,
                        style: const TextStyle(
                          color: Colors.black87,
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
                    Icon(Icons.shopping_bag_outlined, color: blueColor, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      trip['product']!,
                      style: const TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.attach_money, color: blueColor, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      "Price - ${trip['price']}",
                      style: const TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 110,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A56DB),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: CustomText(
                        txt: trip['workOrder']!,
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: const Color(0xFF1A56DB),
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 20,
                    //       vertical: 10,
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(6),
                    //     ),
                    //   ),
                    //   onPressed: () {},
                    //   child: Text(
                    //     trip['workOrder']!,
                    //     style: const TextStyle(fontSize: 13),
                    //   ),
                    // ),
                    Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A56DB),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        trip['index']!,
                        style: const TextStyle(
                          color: Colors.white,
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
    );
  }
}
