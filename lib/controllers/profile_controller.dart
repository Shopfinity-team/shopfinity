import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController{
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPhone = ''.obs;
  var userAddress = ''.obs;
  var userProfileImage = ''.obs;
  var cardNumber = ''.obs;
  var cardType = ''.obs;
  var cardExpiry = ''.obs;

  void getCurrentUser() {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final token = prefs.then((SharedPreferences prefs) {
      return prefs.getString('token') ?? '';
    });

    //use service to get current user

  }

  void logout() {

  }


}