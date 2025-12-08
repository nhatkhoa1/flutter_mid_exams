// lib/models/dummy_product.dart
class DummyProduct {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;

  const DummyProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
  });

  factory DummyProduct.fromJson(Map<String, dynamic> json) {
    return DummyProduct(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      brand: json['brand'] ?? 'Không có thương hiệu',
      category: json['category'],
      thumbnail: json['thumbnail'],
    );
  }
}

class ApiResponse {
  final List<DummyProduct> products;
  const ApiResponse({required this.products});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    return ApiResponse(
      products: list.map((i) => DummyProduct.fromJson(i)).toList(),
    );
  }
}
