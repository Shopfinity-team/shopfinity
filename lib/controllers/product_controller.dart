import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopfinity/services/product_service.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  //loading flags
  final RxBool isAllProductsLoading = true.obs;
  final RxBool isLimitProductsLoading = true.obs;
  final RxBool isRecommendedGroceriesLoading = true.obs;
  final RxBool isSearchLoading = false.obs;
  final RxBool hasSearched = false.obs;

  //product lists
  var products = <Product>[].obs;
  var limitProducts = <Product>[].obs;
  var recommendedGroceries = <Product>[].obs;
  var searchedProducts = <Product>[].obs;
  var addedProducts = <Product>[].obs;

  //image file
  Rx<File?> pickedImage = Rx<File?>(null);
  //for pick an image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImage.value = File(picked.path);
    }
  }

  //get image path
  String getImagePathOrDefault() {
    return pickedImage.value?.path ?? '';
  }

  //for get all products
  Future<void> getAllProducts() async {
    try {
      isAllProductsLoading(true);
      final result = await _productService.getAllProducts();
      if (result != null) {
        products.assignAll(result);
      }
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
    } finally {
      isRecommendedGroceriesLoading(false);
    }
  }

  //for search products
  Future<void> searchProducts(String query) async {
    try {
      isSearchLoading(true);
      hasSearched(true);
      final result = await _productService.searchProducts(query);
      if (result != null) {
        searchedProducts.assignAll(result);
      } else {
        searchedProducts.clear();
      }
    } catch (e) {
      searchedProducts.clear();
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
      if (result != null) {
        final addedProduct = Product.fromJson(result);
        addedProducts.insert(0, addedProduct);
      }
      return result;
    } catch (e) {

      print('Error adding product: $e');

      return null;
    }
  }

  // Update added products list
  void setNewProducts(List<Product> products) {
    addedProducts.value = products;
  }

  //Reset picked image
  void resetPickedImage() {
    pickedImage.value = null;
  }
}
