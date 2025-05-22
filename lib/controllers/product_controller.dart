import 'package:get/get.dart';
import 'package:shopfinity/services/product_service.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  var isAllProductsLoading = true.obs;
  var isLimitProductsLoading = true.obs;
  var isRecommendedGroceriesLoading = true.obs;

  var products = <Product>[].obs;
  var limitProducts = <Product>[].obs;
  var recommendedGroceries = <Product>[].obs;

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
}
