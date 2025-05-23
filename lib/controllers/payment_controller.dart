import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  var paymentStatus = 'Pending'.obs;
  final formkey = GlobalKey<FormState>();

  void processPayment() {

    paymentStatus.value = 'Processing';

    paymentStatus.value = 'Completed';
  }

}