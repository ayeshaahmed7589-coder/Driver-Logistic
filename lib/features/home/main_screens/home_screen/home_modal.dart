// ------------------------------
// SAFE NUM PARSER
// ------------------------------
num parseNum(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value;
  if (value is String) return num.tryParse(value) ?? 0;
  return 0;
}

// ------------------------------
// DASHBOARD MODEL
// ------------------------------
class DashboardModel {
  final DriverInfo driverInfo;
  final Stats stats;
  final Order? activeOrder;
  final List<Order> availableOrders;
  final List<RecentOrder> recentOrders;

  DashboardModel({
    required this.driverInfo,
    required this.stats,
    required this.activeOrder,
    required this.availableOrders,
    required this.recentOrders,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return DashboardModel(
      driverInfo: DriverInfo.fromJson(data['driver_info'] ?? {}),
      stats: Stats.fromJson(data['stats'] ?? {}),
      activeOrder: data['active_order'] != null
          ? Order.fromJson(data['active_order'])
          : null,
      availableOrders: (data['available_orders'] as List<dynamic>? ?? [])
          .map((e) => Order.fromJson(e))
          .toList(),
      recentOrders: (data['recent_orders'] as List<dynamic>? ?? [])
          .map((e) => RecentOrder.fromJson(e))
          .toList(),
    );
  }

  // copyWith to update status
 DashboardModel copyWithStatus(String newStatus) {
  return DashboardModel(
    driverInfo: driverInfo.copyWith(status: newStatus),
    stats: stats,
    activeOrder: activeOrder,
    availableOrders: availableOrders,
    recentOrders: recentOrders,
  );
}
}

// ------------------------------
// DRIVER INFO
// ------------------------------
class DriverInfo {
  final int id;
  final String name;
  final String phone;
  final String licenseNumber;
  final String rating;
  final String status;
  final Vehicle? vehicle;

  DriverInfo({
    required this.id,
    required this.name,
    required this.phone,
    required this.licenseNumber,
    required this.rating,
    required this.status,
    required this.vehicle,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      licenseNumber: json['license_number'] ?? '',
      rating: json['rating']?.toString() ?? '0',
      status: json['status'] ?? '',
      vehicle:
          json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
    );
  }

  // copyWith to update status only
  DriverInfo copyWith({String? status}) {
    return DriverInfo(
      id: id,
      name: name,
      phone: phone,
      licenseNumber: licenseNumber,
      rating: rating,
      status: status ?? this.status,
      vehicle: vehicle,
    );
  }
}

// ------------------------------
// VEHICLE
// ------------------------------
class Vehicle {
  final String registrationNumber;
  final String vehicleType;

  Vehicle({
    required this.registrationNumber,
    required this.vehicleType,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      registrationNumber: json['registration_number'] ?? '',
      vehicleType: json['vehicle_type'] ?? '',
    );
  }
}

// ------------------------------
// STATS MAIN
// ------------------------------
class Stats {
  final StatsSection today;
  final StatsSection week;
  final TotalStats total;

  Stats({
    required this.today,
    required this.week,
    required this.total,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      today: StatsSection.fromJson(json['today'] ?? {}),
      week: StatsSection.fromJson(json['week'] ?? {}),
      total: TotalStats.fromJson(json['total'] ?? {}),
    );
  }
}

// ------------------------------
// EACH STATS SECTION
// ------------------------------
class StatsSection {
  final num earnings;
  final int? orders;

  StatsSection({required this.earnings, this.orders});

  factory StatsSection.fromJson(Map<String, dynamic> json) {
    return StatsSection(
      earnings: parseNum(json['earnings']),
      orders: json['orders'] != null
          ? int.tryParse(json['orders'].toString())
          : null,
    );
  }
}

// ------------------------------
// TOTAL STATS
// ------------------------------
class TotalStats {
  final int completedOrders;
  final String rating;

  TotalStats({required this.completedOrders, required this.rating});

  factory TotalStats.fromJson(Map<String, dynamic> json) {
    return TotalStats(
      completedOrders: json['completed_orders'] ?? 0,
      rating: json['rating']?.toString() ?? '0',
    );
  }
}

// ------------------------------
// ORDER MODEL
// ------------------------------
class Order {
  final int id;
  final String orderNumber;
  final String status;
  final String customerName;
  final String customerPhone;
  final String pickupAddress;
  final String deliveryAddress;
  final String? packageDescription;
  final String? distanceKm;
  final num? estimatedEarning;
  final String? pickupLatitude;
  final String? pickupLongitude;
  final String? deliveryLatitude;
  final String? deliveryLongitude;
  final String? createdAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.pickupAddress,
    required this.deliveryAddress,
    this.packageDescription,
    this.distanceKm,
    this.estimatedEarning,
    this.pickupLatitude,
    this.pickupLongitude,
    this.deliveryLatitude,
    this.deliveryLongitude,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      orderNumber: json['order_number'] ?? '',
      status: json['status'] ?? '',
      customerName: json['customer_name'] ?? '',
      customerPhone: json['customer_phone'] ?? '',
      pickupAddress: json['pickup_address'] ?? '',
      deliveryAddress: json['delivery_address'] ?? '',
      packageDescription: json['package_description'],
      distanceKm: json['distance_km']?.toString(),
      estimatedEarning: parseNum(json['estimated_earning']),
      pickupLatitude: json['pickup_latitude']?.toString(),
      pickupLongitude: json['pickup_longitude']?.toString(),
      deliveryLatitude: json['delivery_latitude']?.toString(),
      deliveryLongitude: json['delivery_longitude']?.toString(),
      createdAt: json['created_at']?.toString(),
    );
  }
}

// ------------------------------
// RECENT ORDER
// ------------------------------
class RecentOrder {
  final int id;
  final String orderNumber;
  final String deliveryAddress;
  final String? completedAt;
  final num? earning;

  RecentOrder({
    required this.id,
    required this.orderNumber,
    required this.deliveryAddress,
    this.completedAt,
    this.earning,
  });

  factory RecentOrder.fromJson(Map<String, dynamic> json) {
    return RecentOrder(
      id: json['id'] ?? 0,
      orderNumber: json['order_number'] ?? '',
      deliveryAddress: json['delivery_address'] ?? '',
      completedAt: json['completed_at']?.toString(),
      earning: parseNum(json['earning']),
    );
  }
}
