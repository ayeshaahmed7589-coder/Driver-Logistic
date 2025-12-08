class OrderModelDetail {
  final String orderId;
  final String pickup;
  final String drop;
  final String earning;
  final String product;
  final String customer;
  final String status;

  OrderModelDetail({
    required this.orderId,
    required this.pickup,
    required this.drop,
    required this.earning,
    required this.product,
    required this.customer,
    required this.status,
  });

  factory OrderModelDetail.fromJson(Map<String, dynamic> json) {
    // Combine product names into a single string
    final items = json['items'] as List<dynamic>? ?? [];
    final productNames = items.map((item) => item['product_name'].toString()).join(", ");

    return OrderModelDetail(
      orderId: json['order_number'] ?? '', // order number from API
      pickup: json['pickup_address'] ?? '',
      drop: json['delivery_address'] ?? '',
      earning: (json['estimated_earning'] ?? 0).toString(), // API field
      product: productNames,
      customer: json['customer_name'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
