import 'package:flutter/material.dart';

import '../../common_widgets/custom_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool hasNotifications = false; // 🔹 Toggle UI state

  List<Map<String, dynamic>> notifications = [
    {
      "title": "WO#: 004–12092283",
      "subtitle": "New work order is added",
      "time": "6 mins ago",
    },
    {
      "title": "WO#: 004–12092283",
      "subtitle": "New work order is added",
      "time": "6 mins ago",
    },
    {
      "title": "WO#: 004–12092283",
      "subtitle": "New work order is added",
      "time": "6 mins ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color blueColor = Color(0xFF004DEB);
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // 🔥 BODY BASED ON STATE
      body: hasNotifications ? _notificationListUI() : _emptyStateUI(),
    );
  }

  // --------------------------
  // 📌 Empty State UI
  // --------------------------
  Widget _emptyStateUI() {
    const Color blueColor = Color(0xFF004DEB);
    return Column(
      children: [
        const SizedBox(height: 40),
        Center(child: Image.asset("assets/empty_notification.png", width: 350)),
        const SizedBox(height: 20),
        const Text(
          "No notifications yet",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "When you have notification, you will see\n them here",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: CustomButton(
            text: "Refresh",
            backgroundColor: blueColor,
            borderColor: blueColor,
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                hasNotifications = true;
              });
            },
            // disables tap when false
          ),
        ),
      ],
    );
  }

  // --------------------------
  // 📌 Notification List UI
  // --------------------------
  Widget _notificationListUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          // TOP ACTION ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Mark all as read",
                  style: TextStyle(
                    color: Color(0xff2C64E3),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Clear All",
                  style: TextStyle(
                    color: Color(0xff2C64E3),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          // LIST
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT BLUE LINE (FULL HEIGHT)
                      Container(
                        height: 70,
                        width: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xff2C64E3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            bottomLeft: Radius.circular(14),
                          ),
                        ),
                      ),

                      // CONTENT
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TITLE + TIME
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item["title"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    item["time"],
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              // SUBTITLE
                              Text(
                                item["subtitle"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
