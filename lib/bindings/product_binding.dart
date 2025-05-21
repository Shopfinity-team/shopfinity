import 'package:get/get.dart';
import 'package:shopfinity/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
  }
}
