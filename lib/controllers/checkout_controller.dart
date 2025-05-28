import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> processCheckout() async {
    
  }
}