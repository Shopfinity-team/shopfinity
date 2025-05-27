import 'package:get/get.dart';
import 'package:shopfinity/services/product_service.dart';

import '../model/product_model.dart';

class  ProductController extends GetxController {
  final ProductService _productService = ProductService();

  var isAllProductsLoading = true.obs;
  var isLimitProductsLoading = true.obs;
  var isRecommendedGroceriesLoading = true.obs;
  var isSearchLoading = true.obs;

  var products = <Product>[].obs;
  var limitProducts = <Product>[].obs;
  var recommendedGroceries = <Product>[].obs;
  var searchedProducts = <Product>[].obs;

  //for get all products
  Future<void> getAllProducts() async {
    try {
      isAllProductsLoading(true);
      final result = await _productService.getAllProducts();
      if (result != null) {
        products.assignAll(result);
      }
    } catch (e) {
      print('error fetching all products');
    } finally {
      isAllProductsLoading(false);
    }
  }

  //for get limit products

  Future<void> getLimitProducts() async {
    try {
      isLimitProductsLoading(true);
      final result = await _productService.getLimitProducts();

      if (result != null) {
        limitProducts.assignAll(result);
      }
    } catch (e) {
      print('error fetching limit products');
    } finally {
      isLimitProductsLoading(false);
    }
  }

  //for get recommended groceries
  Future<void> getRecommendedGroceries() async {
    try {
      isRecommendedGroceriesLoading(true);
      final result = await _productService.getRecommendedGroceries();
      if (result != null) {
        recommendedGroceries.assignAll(result);
      }
    } catch (e) {
      print('error fetching recommended groceries');
    } finally {
      isRecommendedGroceriesLoading(false);
    }
  }

  //for search products
  Future<void> searchProducts(String query) async {
    try {
      isSearchLoading(true);
      final result = await _productService.searchProducts(query);
      print(result);
      if (result != null) {
        searchedProducts.assignAll(result);
      }
    } catch (e) {
      print('error searching items');
    } finally {
      isSearchLoading(false);
    }
  }

  //for add a product
  Future<Map<String, dynamic>?> addProduct(Product product) async {
    final newProduct = {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'thumbnail': product.imageUrl,
    };
    try {
      final result = await _productService.addProduct(newProduct);
      print(result);
      return result;
    } catch (e) {
      print(e);
    }
  }
}
