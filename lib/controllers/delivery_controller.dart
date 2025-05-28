import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinity/services/profile_service.dart';

class DeliveryController extends GetxController {

  var deliveryStatus = 'Pending'.obs;
  var country = ''.obs;
  var address = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var postalCode = ''.obs;

  ProfileService profileService = ProfileService();

  void updateDeliveryStatus(String status) {
    deliveryStatus.value = status;
  }

  Future<void> getCurrentLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';

      final response = await profileService.getCurrentUser(token);
      country.value = response['address']['country'];
      address.value = response['address']['address'];
      city.value = response['address']['city'];
      state.value = response['address']['state'];
      postalCode.value = response['address']['postalCode'];
      print(  "Current location fetched successfully: $country, $address, $city, $state, $postalCode");
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }
}