import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../export.dart';
import 'order_details_screen/order_detail_controller.dart';
import 'order_details_screen/order_detail_modal.dart';

class MapScreen extends ConsumerStatefulWidget {
  final int orderId;
  final String type;

  const MapScreen({super.key, required this.orderId, required this.type});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

/// ------------------- Location Wrapper -------------------
class LocationWrapper {
  final String address;
  final String city;
  final String state;
  final String contactName;
  final String contactPhone;
  final String? otp;
  final String? instructions;
  final String latitude;
  final String longitude;

  LocationWrapper.pickup(Pickup pickup)
    : address = pickup.address,
      city = pickup.city,
      state = pickup.state,
      contactName = pickup.contactName,
      contactPhone = pickup.contactPhone,
      otp = pickup.otp,
      instructions = null,
      latitude = pickup.latitude,
      longitude = pickup.longitude;

  LocationWrapper.delivery(Delivery delivery)
    : address = delivery.address,
      city = delivery.city,
      state = delivery.state,
      contactName = delivery.contactName,
      contactPhone = delivery.contactPhone,
      otp = delivery.otp,
      instructions = delivery.instructions,
      latitude = delivery.latitude,
      longitude = delivery.longitude;
}

/// ------------------- State -------------------
class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _driverLocation; // Current device location
  late LatLng _targetLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    // Check permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permissions are permanently denied'),
        ),
      );
      return;
    }

    // Get current position
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _driverLocation = LatLng(position.latitude, position.longitude);
    });
  }

  LatLng parseLatLng(String lat, String lng) {
    final parsedLat = double.tryParse(lat.trim()) ?? 0.0;
    final parsedLng = double.tryParse(lng.trim()) ?? 0.0;
    return LatLng(parsedLat, parsedLng);
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(
      orderDetailsControllerProvider(widget.orderId),
    );

    return orderAsync.when(
      data: (order) {
        final location = widget.type == "pickup"
            ? LocationWrapper.pickup(order.pickup)
            : LocationWrapper.delivery(order.delivery);

        _targetLocation = parseLatLng(location.latitude, location.longitude);

        // If driver location is still null, show loading
        if (_driverLocation == null) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.lightGrayBackground,
            ),
          );
        }

        return Scaffold(
          body: Stack(
            children: [
              // ------------------- MAP -------------------
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _driverLocation ?? LatLng(0, 0),
                  initialZoom: 13,
                  minZoom: 5,
                  maxZoom: 18,
                  onTap: (tapPosition, point) {},
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  if (_driverLocation != null) ...[
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [_driverLocation!, _targetLocation],
                          strokeWidth: 4,
                          color: AppColors.electricTeal,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 30,
                          height: 30,
                          point: _driverLocation!,
                          child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: AppColors.electricTeal,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Marker(
                          width: 40,
                          height: 40,
                          point: _targetLocation,
                          child: Icon(
                            Icons.location_on,
                            size: 36,
                            color: widget.type == "pickup"
                                ? Colors.deepOrange
                                : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              // ------------------- BACK BUTTON -------------------
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
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

              // ------------------- ORDER INFO FLOATING -------------------
              Positioned(
                top: MediaQuery.of(context).padding.top + 60,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 6),
                    ],
                  ),
                  child: Text(
                    "Order ID: ${widget.orderId} | Type: ${widget.type.toUpperCase()}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // ------------------- BOTTOM SHEET -------------------
              DraggableScrollableSheet(
                initialChildSize: 0.3,
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          Text(
                            widget.type == "pickup"
                                ? "Pickup Location"
                                : "Delivery Location",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 20,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "${location.address}, ${location.city}, ${location.state}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.darkText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Contact: ${location.contactName} - ${location.contactPhone}",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.darkText,
                            ),
                          ),
                          if (widget.type == "pickup" && location.otp != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "OTP: ${location.otp}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.darkText,
                                ),
                              ),
                            ),
                          if (widget.type == "delivery" &&
                              location.instructions != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "Instructions: ${location.instructions}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.darkText,
                                ),
                              ),
                            ),
                          SizedBox(height: 18),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () async {
                                  final Uri url = Uri.parse(
                                    "tel:${location.contactPhone}",
                                  );
                                  if (await canLaunchUrl(url))
                                    await launchUrl(url);
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
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.electricTeal,
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    widget.type == "pickup"
                                        ? "Mark as Picked Up"
                                        : "Mark as Delivered",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text("Error loading order: $e")),
    );
  }
}
