import 'package:get/get.dart';
import 'package:shopfinity/model/product_model.dart';

class ProductService extends GetConnect {
  ProductService() {
    httpClient.baseUrl = 'https://dummyjson.com';
  }

  //for get all products
  Future<List<Product>?> getAllProducts() async {
    final response = await get('/products');

    // print('product service');
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200 && response.body != null) {
      final jsonData = response.body;
      final List productsJson = jsonData['products'];

      return productsJson
          .map((product) => Product.fromJson(product))
          .toList()
          .cast<Product>();
    } else {
      throw Exception('failed to fetch products');
    }
  }

  //for get limit products
  Future<List<Product>?> getLimitProducts() async {
    final response = await get('/products?limit=10&skip=10');

    //print(response.statusCode);
    //print(response.body); //ok

    if (response.statusCode == 200 && response.body != null) {
      final jsonData = response.body;
      final List productsJson = jsonData['products'];

      return productsJson
          .map((product) => Product.fromJson(product))
          .toList()
          .cast<Product>();
    } else {
      throw Exception('failed to fetch limit products');
    }
  }

  //for fetch groceries for home screen
  Future<List<Product>?> getRecommendedGroceries() async {
    final response = await get('/products/category/groceries');

    if (response.statusCode == 200 && response.body != null) {
      final jsonData = response.body;
      final List productsJson = jsonData['products'];

      return productsJson
          .map((product) => Product.fromJson(product))
          .toList()
          .cast<Product>();
    } else {
      throw Exception('failed to fetch recommended groceries');
    }
  }

  //for search products
  Future<List<Product>?> searchProducts(String query) async {
    final response = await get('/products/search?q=$query');
    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200 && response.body != null) {
      final jsonData = response.body;
      final List productsJson = jsonData['products'];

      return productsJson
          .map((product) => Product.fromJson(product))
          .toList()
          .cast<Product>();
    } else {
      throw Exception('failed to fetch recommended groceries');
    }
  }

  //for add a product
  Future<Map<String, dynamic>?> addProduct(Map<String, dynamic> Product) async {
    final response = await post(
      '/products/add',
      Product,
      headers: {'Content-Type': 'application/json'},
    );

    if ((response.statusCode == 200 || response.statusCode == 201) &&
        response.body != null) {
      return response.body;
    } else {
      throw Exception('error posting : ${response.body}');
    }
  }
}
