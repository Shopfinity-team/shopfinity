import 'package:get/get.dart';

class CategoryController extends GetxController{
  var selectedCategoryIndex = 0.obs;
  var categories = [
    "All",
    "Beauty",
    "Electronics",
    "Fashion",
    "Home",
    "Sports",
    "Toys",
  ].obs;

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }
}