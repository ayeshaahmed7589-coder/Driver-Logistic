class OrderModelDetail {
  final int orderId;
  final String pickup;
  final String ordernumber;
  final String drop;
  final String earning;
  final String product;
  final String customer;
  final String status;

  OrderModelDetail({
    required this.orderId,
    required this.ordernumber,
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
      orderId: int.tryParse(json['id'].toString()) ?? 0,
      pickup: json['pickup_address'] ?? '',
      drop: json['delivery_address'] ?? '',
      ordernumber: json['order_number'] ?? '',
      earning: (json['estimated_earning'] ?? 0).toString(), // API field
      product: productNames,
      customer: json['customer_name'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
