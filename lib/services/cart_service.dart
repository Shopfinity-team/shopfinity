import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopfinity/model/cart_model.dart';
import 'package:shopfinity/model/product_model.dart';

class CartService {
  Future<int> addToCart(String userId, List<Product> products) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/carts/add'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'products': products.map((product) {
          return {
            'id': product.id,
            'quantity': product.quantity.value,
          };
        }).toList(),
      })
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id']; 
    } else {
      throw Exception('Failed to add products to cart');
    }
  }

  Future<Map<String, dynamic>> getCartItemsCount(String userId) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/carts/user/$userId'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch cart items');
    }
  }

  Future<void> removeCart(int? cartId, int productId) async{
    final response = await http.delete(
      Uri.parse('https://dummyjson.com/carts/$cartId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove cart');
    }
  }

  Future<void> updateCart(int? cartId, int productId, int quantity) async {
    final response = await http.put(
      Uri.parse('https://dummyjson.com/carts/$cartId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart');
    }
  }
}