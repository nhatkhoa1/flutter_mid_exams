// lib/services/api_dummy.dart
import 'package:dio/dio.dart';
import '../models/dummy_product.dart';

class ApiService {
  final Dio _dio = Dio();

  // Lấy tất cả sản phẩm (30 sản phẩm đầu)
  Future<ApiResponse> getAllProducts() async {
    try {
      final response = await _dio.get(
        'https://dummyjson.com/products?limit=30',
      );
      return ApiResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }

  // Lấy sản phẩm theo ID
  Future<DummyProduct> getProductById(int id) async {
    try {
      final response = await _dio.get('https://dummyjson.com/products/$id');
      return DummyProduct.fromJson(response.data);
    } catch (e) {
      throw Exception('Không tải được chi tiết sản phẩm');
    }
  }

  // Tìm kiếm sản phẩm
  Future<ApiResponse> searchProducts(String query) async {
    try {
      final response = await _dio.get(
        'https://dummyjson.com/products/search?q=${Uri.encodeComponent(query)}&limit=30',
      );
      return ApiResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi tìm kiếm: $e');
    }
  }
}

// Instance để dùng toàn app
final dummy_api = ApiService();
