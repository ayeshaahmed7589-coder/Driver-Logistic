// lib/repositories/order_repository.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logisticdriverapp/constants/local_storage.dart';
import '../../../../constants/api_url.dart';
import '../../../../constants/dio.dart';
import 'my_order_modal.dart';

/// Repository Provider
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return OrderRepository(dio: dio);
});

class OrderRepository {
  final Dio dio;

  OrderRepository({required this.dio});

  /// Fetch My Orders
  Future<List<OrderModelDetail>> getMyOrders() async {
    try {
      final token = await LocalStorage.getToken();

      final response = await dio.get(
        ApiUrls.myorders,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            if (token != null && token.isNotEmpty)
              "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => OrderModelDetail.fromJson(e)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load My Orders');
      }
    } on DioError catch (e) {
      final msg = e.response?.data['message'] ?? e.message;
      throw Exception("Network error: $msg");
    }
  }

  /// Fetch Available Orders
  Future<List<OrderModelDetail>> getAvailableOrders() async {
    try {
      final token = await LocalStorage.getToken();

      final response = await dio.get(
        ApiUrls.availableorders,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            if (token != null && token.isNotEmpty)
              "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((e) => OrderModelDetail.fromJson(e)).toList();
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to load Available Orders',
        );
      }
    } on DioError catch (e) {
      final msg = e.response?.data['message'] ?? e.message;
      throw Exception("Network error: $msg");
    }
  }
}
