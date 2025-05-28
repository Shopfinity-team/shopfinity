import 'package:shopfinity/model/product_model.dart';

class Cart {
  final String id;
  final List<Product> products;
  double totalPrice = 0;

  Cart({
    required this.id,
    required this.products,
  });

  double getTotalPrice() {
    totalPrice = products.fold(
        0.0, (sum, product) => sum + (product.price * product.quantity.value));
    return totalPrice;
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'].toString(),
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}
