// lib/services/api.dart
import 'package:dio/dio.dart';
import '../models/product.dart'; // ← import model

class Api {
  final Dio _dio = Dio();

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Lỗi: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Lỗi mạng: ${e.message}');
    }
  }
}

final api = Api(); // ← đổi tên từ test_api → api
