import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../export.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  // SAMPLE coordinates - replace with real ones
  final LatLng _driverLocation = LatLng(51.515, -0.09);
  final LatLng _pickupLocation = LatLng(51.52, -0.1);
  final LatLng _deliveryLocation = LatLng(51.505, -0.08);

  @override
  Widget build(BuildContext context) {
    final Color blueColor = AppColors.electricTeal;
    return Scaffold(
      body: Stack(
        children: [
          // Full screen map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(minZoom: 5, maxZoom: 18),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.logisticdriverapp',
              ),

              // Polyline (route) layer
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      _driverLocation,
                      _pickupLocation,
                      _deliveryLocation,
                    ],
                    strokeWidth: 4.0,
                    // flutter_map uses color directly; using AppColors if available
                    color: blueColor,
                  ),
                ],
              ),

              // Markers
              MarkerLayer(
                markers: [
                  // Driver (blue dot)
                  Marker(
                    width: 30,
                    height: 30,
                    point: _driverLocation,
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.electricTeal,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 4),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Pickup (orange pin)
                  Marker(
                    width: 40,
                    height: 40,
                    point: _pickupLocation,
                    child: Icon(
                      Icons.location_on,
                      size: 36,
                      color: Colors.deepOrange,
                    ),
                  ),

                  // Delivery (green pin)
                  Marker(
                    width: 40,
                    height: 40,
                    point: _deliveryLocation,
                    child: Icon(
                      Icons.location_on,
                      size: 36,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Circular back button (left-top)
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: GestureDetector(
              onTap: () {
                context.go("/order-details");
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: AppColors.darkText,
                ),
              ),
            ),
          ),

          // Floating header with Order #
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                constraints: BoxConstraints(minWidth: 200, maxWidth: 360),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Order #12345",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 12),
                    Container(
                      height: 20,
                      width: 1,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Floating header",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // close or expand action
                      },
                      child: Icon(
                        Icons.chevron_left,
                        size: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Draggable bottom sheet
          DraggableScrollableSheet(
            initialChildSize: 0.28, // sheet visible height ratio
            minChildSize: 0.12,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          width: 48,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),

                      // ETA & Distance row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Estimated Time",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "15 min",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Distance",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "5.2 km",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 18),

                      // Next Pickup section
                      Text(
                        "Next: Pickup Location",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "No 2. Balonny Close, Allen Avenue",
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.darkText,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),

                      // Buttons row: Call Customer + Mark as Picked Up
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              // call action (use url_launcher)
                            },
                            icon: Icon(Icons.phone, size: 18),
                            label: Text("Call Customer"),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              text: "Mark as Packed Up",
                              backgroundColor: blueColor,

                              borderColor: blueColor,
                              textColor: AppColors.pureWhite,
                              onPressed: () {
                                // action
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Optional extra info like traffic, ETA details
                      Row(
                        children: [
                          Icon(Icons.traffic, size: 18, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Traffic conditions (if available)",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 18, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "ETA and distance display",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
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
}
