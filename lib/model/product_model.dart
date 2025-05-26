import 'package:get/get.dart';

class Product {
  final String title;
  final String imageUrl;
  final double price;
  final double? productRate;
  final String? description;
  RxInt quantity = 1.obs;

  Product(
      {required this.title,
      required this.imageUrl,
      required this.price,
      this.productRate,
      this.description,
      });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      imageUrl: json['thumbnail'],
      price: (json['price'] as num).toDouble(),
      productRate: (json['rating'] as num).toDouble(),
      description: json['description'],
    );
  }
}
