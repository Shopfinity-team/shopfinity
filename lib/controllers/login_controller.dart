import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinity/controllers/cart_controller.dart';
import 'package:shopfinity/controllers/profile_controller.dart';
import 'package:shopfinity/services/login_service.dart';
import 'package:shopfinity/shared/widgets/custom_alert.dart';

class LoginController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  RxBool isLoggedIn = false.obs;

  final LoginService _loginService = LoginService();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
      try {
        final token = await _loginService.login(username.text, password.text);

        if (token != null) {
          isLoggedIn.value = true;
          // Store user profile details
          final profileController = Get.put(ProfileController());
          String userId = profileController.userId.value;

          // Initialize the cart for this user
          final cartController = Get.put(CartController());
          await cartController.initializeCartForUser(userId);

          await showCustomAlert(
            title: 'Success',
            message: 'You have logged in successfully!',
          );

          Get.toNamed('/navbar');
        } else {
          await showCustomAlert(
              title: 'Login Failed',
              message: 'Invalid username or password',
              isError: true);
        }
      } catch (e) {
        await showCustomAlert(
            title: 'Login Failed',
            message: 'An error occurred: $e',
            isError: true);
      } finally {
        isLoading.value = false;
      }
    } 

  void logout() async {
    final confirm = await showCustomAlert(
        title: 'Confirm Logout',
        message: 'Are you sure want to log out?',
        isConfirm: true);

    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      isLoggedIn.value = false;
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');

      await showCustomAlert(
        title: 'Success',
        message: 'You have logged out successfully!',
      );
      Get.offAllNamed('/login');
    }
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }
}
