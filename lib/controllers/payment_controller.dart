import 'package:get/get.dart';

class PaymentController extends GetxController {
  var paymentStatus = 'Pending'.obs;

  void processPayment() {

    paymentStatus.value = 'Processing';

    paymentStatus.value = 'Completed';
  }

}