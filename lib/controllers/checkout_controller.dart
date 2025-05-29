import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinity/controllers/cart_controller.dart';
import 'package:shopfinity/controllers/profile_controller.dart';

class CheckoutController extends GetxController {
  var isLoading = false.obs;
  var country = ''.obs;
  var address = ''.obs;
  var apt = ''.obs;
  var district = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var postalCode = ''.obs;
  var deliveryStatus = 'Pending'.obs;
  var paymentStatus = 'Pending'.obs;
  var nameOnCard = ''.obs;
  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var cvv = ''.obs;

  final CartController cartController = Get.find();
  final ProfileController profileController = Get.find();

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> processCheckout() async {
    toggleLoading();
    try {
      final sharedPrefs = await SharedPreferences.getInstance();

      country.value = sharedPrefs.getString('country') ?? ''; 
      address.value = sharedPrefs.getString('address') ?? '';
      apt.value = sharedPrefs.getString('apt') ?? '';
      district.value = sharedPrefs.getString('district') ?? '';
      city.value = sharedPrefs.getString('city') ?? '';
      state.value = sharedPrefs.getString('state') ?? '';
      postalCode.value = sharedPrefs.getString('postalCode') ?? '';

      if ([country, address, city, state, postalCode].any((element) => element.value.isEmpty)) {
        Get.snackbar('Error', 'Please complete your delivery address before proceeding.');
        return;
      }

      nameOnCard.value = sharedPrefs.getString('nameOnCard') ?? '';
      cardNumber.value = sharedPrefs.getString('cardNumber') ?? '';
      expiryDate.value = sharedPrefs.getString('expiryDate') ?? '';
      cvv.value = sharedPrefs.getString('cvv') ?? '';

      // if ([nameOnCard, cardNumber, expiryDate, cvv].any((element) => element.value.isEmpty)) {
      //   Get.snackbar('Error', 'Please complete your payment details before proceeding.');
      //   return;
      // }

      final orderDetails = {
        'country': country.value,
        'address': address.value,
        'city': city.value,
        'apt': apt.value,
        'district': district.value,
        'state': state.value,
        'postalCode': postalCode.value,
        'nameOnCard': nameOnCard.value,
        'cardNumber': cardNumber.value,
        'expiryDate': expiryDate.value,
        'cvv': cvv.value,
        'cartItems': cartController.cartItems.map((item) => item.toJson()).toList(),
        'totalPrice': cartController.totalPrice.value,
      };

      await sharedPrefs.setString('orderDetails', jsonEncode(orderDetails));
      print(sharedPrefs.getString('orderDetails'));
      final keys = sharedPrefs.getKeys();
      for (var key in keys) {
        if (key != 'orderDetails' && key != 'access_token' && key != 'refresh_token') {
          await sharedPrefs.remove(key);
        }
      }
      Get.snackbar('Success', 'Checkout completed successfully!');
      Get.toNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Failed to complete checkout: $e');
    } finally {
      toggleLoading();
    }
  }
}
