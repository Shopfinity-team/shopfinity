import 'package:get/get.dart';

class Product {
  final int? id;
  final String title;
  final String imageUrl;
  final double price;
  final double? productRate;
  final String? description;
  RxInt quantity = 1.obs;

  Product(
      {
      this.id,
      required this.title,
      required this.imageUrl,
      required this.price,
      this.productRate,
      this.description,
      });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['thumbnail'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      productRate:
          (json['rating'] != null) ? (json['rating'] as num).toDouble() : 0.0,

    
      description: json['description'],
    );
  }
}
