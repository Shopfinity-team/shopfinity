import 'package:get/get.dart';
import 'package:shopfinity/services/product_service.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  var products = <Product>[].obs;
  var isLoading = true.obs;

  //for get all products
  Future<void> getAllProducts() async {
    try {
      isLoading(true);
      final result = await _productService.getAllProducts();
      if (result != null) {
        products.assignAll(result);
      }
    } catch (e) {
      print('error fetching all products');
    } finally {
      isLoading(false);
    }
  }

  //for get limit products

  Future<void> getLimitProducts() async {
    try {
      isLoading(true);
      final result = await _productService.getLimitProducts();

      if (result != null) {
        products.assignAll(result);
      }
    } catch (e) {
      print('error fetching limit products');
    } finally {
      isLoading(false);
    }
  }
}
