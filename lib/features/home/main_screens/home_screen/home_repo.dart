import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/api_url.dart';
import '../../../../constants/dio.dart';
import 'home_modal.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return DashboardRepository(dio: dio);
});

class DashboardRepository {
  final Dio dio;

  DashboardRepository({required this.dio});

  Future<String> updateAvailability(bool isOnline) async {
    try {
      final resp = await dio.put(
        ApiUrls.available,
        data: {"status": isOnline ? "available" : "off_duty"},
      );

      if (resp.statusCode == 200) {
        // return status from backend
        return resp.data["data"]["status"] ?? (isOnline ? "available" : "off_duty");
      }

      throw Exception(resp.data["message"] ?? "Failed to update status");
    } on DioError catch (e) {
      final msg = e.response?.data["message"] ?? e.message;
      throw Exception(msg);
    }
  }

  Future<DashboardModel> fetchDashboard() async {
    try {
      final resp = await dio.get(ApiUrls.dashboard);
      if (resp.statusCode == 200) {
        final data = resp.data as Map<String, dynamic>;
        return DashboardModel.fromJson(data);
      } else {
        throw Exception('Failed to load dashboard: ${resp.statusCode}');
      }
    } on DioError catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception('Network error: $msg');
    }
  }
}
