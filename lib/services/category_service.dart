import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<Map<String, dynamic>> getCategoryProducts(String category) async{
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products/category/${category}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch category products');
    }
  }
}