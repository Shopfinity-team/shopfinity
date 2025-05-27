import 'package:get/get.dart';
import 'package:shopfinity/model/product_model.dart';
import 'package:shopfinity/services/category_service.dart';
import 'package:shopfinity/shared/widgets/categories.dart';

class CategoryController extends GetxController{
  var selectedCategoryIndex = 0.obs;
  RxString selectedCategory = 'beauty'.obs;

  CategoryService categoryService = CategoryService();

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    setSelectedCategory();
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

  Future<List<Product>> getCategoryProducts(String category) async {
    try {
      final response = await categoryService.getCategoryProducts(category);
      if (response.isNotEmpty) {
        List<Product> products = (response['products'] as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return products;
      } else {
        throw Exception('No products found for category $category');
      }
    } catch (e) {
      print("Error fetching products for category $category: $e");
      throw Exception("Error fetching products for category $category: $e");
    }
  }

}