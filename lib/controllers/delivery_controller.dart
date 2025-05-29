import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinity/services/profile_service.dart';
import 'package:shopfinity/shared/widgets/custom_alert.dart';

class DeliveryController extends GetxController {
  var deliveryStatus = 'Pending'.obs;
  var country = '';
  var address = '';
  var city = '';
  var state = '';
  var postalCode = '';

  ProfileService profileService = ProfileService();

  void updateDeliveryStatus(String status) {
    deliveryStatus.value = status;
  }

  Future<void> getCurrentLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token') ?? '';

      final response = await profileService.getCurrentUser(token);

      country = response['address']['country'];
      address = response['address']['address'];
      city = response['address']['city'];
      state = response['address']['state'];
      postalCode = response['address']['postalCode'];
      print(
          "Current location fetched successfully: $country, $address, $city, $state, $postalCode");
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  void updateAddress(String country, String newAddress, String? apt,
      String? district, String city, String state, String postalCode) async {
    this.country = country;
    this.address = newAddress;
    this.city = city;
    this.state = state;
    this.postalCode = postalCode;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('country', country);
      prefs.setString('address', newAddress);
      prefs.setString('apt', apt ?? '');
      prefs.setString('district', district ?? '');
      prefs.setString('city', city);
      prefs.setString('state', state);
      prefs.setString('postalCode', postalCode);
    });

    await showCustomAlert(
        title: 'Success',
        message: 'Your delivery address has been updated successfully');

    Get.toNamed('/checkout');
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }
}
