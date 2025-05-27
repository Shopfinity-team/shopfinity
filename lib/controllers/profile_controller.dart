import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinity/services/profile_service.dart';

class ProfileController extends GetxController{
  var userId = ''.obs; // userId should be a String observable
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPhone = ''.obs;
  var userAddress = ''.obs;
  var userProfileImage = ''.obs;
  var cardNumber = ''.obs;
  var cardType = ''.obs;
  var cardExpiry = ''.obs;

  ProfileService profileService = ProfileService();

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';
      print(token);

      final response = await profileService.getCurrentUser(token);

      userId.value = response['id'].toString();
      userName.value = response['username'];
      userEmail.value = response['email'] ;
      userPhone.value = response['phone'];
      userAddress.value = response['address']['address']+ ', ' +
          response['address']['city'] + ', ' +
          response['address']['state'] + ', ' +
          response['address']['postalCode'] + ', ' +
          response['address']['country'];
      userProfileImage.value = response['image'];
      cardNumber.value = response['bank']['cardNumber'];
      cardType.value = response['bank']['cardType'];
      cardExpiry.value = response['bank']['cardExpire'];
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    Get.offAllNamed('/login');
  }

}