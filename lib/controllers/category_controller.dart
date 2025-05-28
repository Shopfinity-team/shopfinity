import 'package:get/get.dart';
import 'package:shopfinity/model/product_model.dart';
import 'package:shopfinity/services/category_service.dart';
import 'package:shopfinity/shared/widgets/categories.dart';

class CategoryController extends GetxController{
  var selectedCategoryIndex = 0.obs;
  RxString selectedCategory = 'beauty'.obs;
  RxBool isLoading = false.obs;
  List<Product> products = [];

  CategoryService categoryService = CategoryService();

  @override
  void onInit() {
    super.onInit();
    getCategoryProducts(selectedCategory.value);
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    setSelectedCategory();
    getCategoryProducts(selectedCategory.value);
  }

  int getSelectedCategory() {
    return selectedCategoryIndex.value;
  }

  void setSelectedCategory() {
    selectedCategory.value = Categories.categories[selectedCategoryIndex.value]['title'];
  }

  String getSelectedCategoryName() {
    return selectedCategory.value;
  }

  Future<void> getCategoryProducts(String category) async {
    try {
      isLoading.value = true;
      products.clear();
      update();
      final response = await categoryService.getCategoryProducts(category);
      if (response.isNotEmpty) {
        products = (response['products'] as List)
            .map((product) => Product.fromJson(product))
            .toList();
      isLoading.value = false;
      update();
      } else {
        throw Exception('No products found for category $category');
      }
    } catch (e) {
      print("Error fetching products for category $category: $e");
      throw Exception("Error fetching products for category $category: $e");
    }
  }

}