import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_detail_modal.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(dio: Dio());
});

class OrderRepository {
  final Dio dio;

  OrderRepository({required this.dio});

  Future<OrderModel> getOrderDetails(int id) async {
    try {
      final response = await dio.get(
        "https://seedlink.skyguruu.com/api/v1/driver/orders/$id",
      );

      print("Raw API response: ${response.data}");

      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to load order");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
