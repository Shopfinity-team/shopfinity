import 'package:get/get.dart';
import 'package:shopfinity/shared/widgets/categories.dart';

class CategoryController extends GetxController{
  var selectedCategoryIndex = 0.obs;
  RxString selectedCategory = 'beauty'.obs;

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

}