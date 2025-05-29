import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinity/services/profile_service.dart';

class PaymentController extends GetxController {
  var paymentStatus = 'Pending'.obs;
  var nameOnCard = '';
  var cardNumber = '';
  var expiryDate = '';
  var cvv = '';
  final formkey = GlobalKey<FormState>();

  ProfileService profileService = ProfileService();

  @override
  void onInit() {
    super.onInit();
    getCurrentPaymentdetails();
    printPaymentDetails();
  } 

  Future<void> getCurrentPaymentdetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token') ?? '';

    final response = await profileService.getCurrentUser(token);

    nameOnCard = response['username'] ?? '';
    cardNumber = response['bank']['cardNumber'] ?? '';
    expiryDate = response['bank']['cardExpire'] ?? '';
    cvv = response['bank']['cvv'] ?? '123';
  }

  void updatePaymentDetails(String name, String cardNum, String expiry, String cvvCode) {
    nameOnCard = name;
    cardNumber = cardNum;
    expiryDate = expiry;
    cvv = cvvCode;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('nameOnCard', name);
      prefs.setString('cardNumber', cardNum);
      prefs.setString('expiryDate', expiry);
      prefs.setString('cvv', cvvCode);
    });

    Get.snackbar(
      "Payment Details Updated",
      "Your payment details have been updated successfully.",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.toNamed('/checkout');
  }

  void printPaymentDetails() {
    print("Name on Card: $nameOnCard");
    print("Card Number: $cardNumber");
    print("Expiry Date: $expiryDate");
    print("CVV: $cvv");
  }

}