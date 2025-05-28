import 'package:flutter/widgets.dart';
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
  } 

  Future<void> getCurrentPaymentdetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token') ?? '';

    final response = await profileService.getCurrentUser(token);

    nameOnCard = response['paymentDetails']['nameOnCard'] ?? '';
    cardNumber = response['paymentDetails']['cardNumber'] ?? '';
    expiryDate = response['paymentDetails']['expiryDate'] ?? '';
    cvv = response['paymentDetails']['cvv'] ?? '';
  }

  void processPayment() {

    paymentStatus.value = 'Processing';

    paymentStatus.value = 'Completed';
  }

}