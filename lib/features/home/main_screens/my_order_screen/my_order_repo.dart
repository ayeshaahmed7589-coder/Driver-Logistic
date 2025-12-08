// lib/repositories/order_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/api_url.dart';
import '../../../../constants/dio.dart';
import 'my_order_modal.dart';

/// Repository Provider
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final dio = ref.watch(dioProvider); // Dio instance from your constants
  return OrderRepository(dio: dio);
});

class OrderRepository {
  final Dio dio;

  OrderRepository({required this.dio});

  /// Fetch My Orders
  Future<List<OrderModel>> getMyOrders() async {
    try {
      final response = await dio.get(ApiUrls.myorders);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load My Orders');
      }
    } on DioError catch (e) {
      final msg = e.response?.data['message'] ?? e.message;
      throw Exception('Network error: $msg');
    }
  }

  /// Fetch Available Orders
  Future<List<OrderModel>> getAvailableOrders() async {
    try {
      final response = await dio.get(ApiUrls.availableorders);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load Available Orders');
      }
    } on DioError catch (e) {
      final msg = e.response?.data['message'] ?? e.message;
      throw Exception('Network error: $msg');
    }
  }
}
