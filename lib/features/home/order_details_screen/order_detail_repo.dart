import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logisticdriverapp/constants/local_storage.dart';

import 'order_detail_modal.dart';

// Token provider

// Repository provider jo token access kare
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final dio = Dio();

  return OrderRepository(dio: dio);
});

class OrderRepository {
  final Dio dio;

  OrderRepository({required this.dio});

  Future<OrderModel> getOrderDetails(int id) async {
    try {
      // Token fetch karein
      final token = await LocalStorage.getToken();

      // Headers set karein
      final headers = {
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      print("Token: ${token != null ? 'Present' : 'Not found'}");

      final response = await dio.get(
        "https://seedlink.skyguruu.com/api/v1/driver/orders/$id",
        options: Options(headers: headers),
      );

      print("Raw API response: ${response.data}");

      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to load order. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("API Error: $e");
      throw Exception("Network error: ${e.toString()}");
    }
  }
}

// final orderRepositoryProvider = Provider<OrderRepository>((ref) {
//   return OrderRepository(dio: Dio());
// });

// class OrderRepository {
//   final Dio dio;

//   OrderRepository({required this.dio});

// Future<OrderModel> getOrderDetails(int id) async {
//   try {
//     final response = await dio.get("https://seedlink.skyguruu.com/api/v1/driver/orders/$id");
//     print("Raw API response: ${response.data}");

//     if (response.statusCode == 200) {
//       // Yahan se data['data'] nikal rahe ho
//       return OrderModel.fromJson(response.data['data']); // ✅ sahi hai
//     } else {
//       throw Exception("Failed to load order");
//     }
//   } catch (e) {
//     throw Exception(e.toString());
//   }
// }
// }


//////////////

  // Future<OrderModel> getOrderDetails(int id) async {
  //   try {
  //     final response = await dio.get(
  //       "https://seedlink.skyguruu.com/api/v1/driver/orders/$id",
  //     );

  //     print("Raw API response: ${response.data}");

  //     if (response.statusCode == 200) {
  //       return OrderModel.fromJson(response.data['data']);
  //     } else {
  //       throw Exception("Failed to load order");
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }



