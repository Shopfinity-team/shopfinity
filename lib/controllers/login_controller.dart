import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinity/services/login_service.dart';

class LoginController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  RxBool isLoggedIn = false.obs;

  final formKey = GlobalKey<FormState>();
  final LoginService _loginService = LoginService();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    final formState = formKey.currentState;

    if (formState == null) {
      Get.snackbar("Error", "Form state is null",
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (formState.validate()) {
      isLoading.value = true;

      try {
        final token = await _loginService.login(username.text, password.text);

        if (token != null) {
          Get.snackbar(
            "Success",
            "Logged in successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          isLoggedIn.value = true;
          Get.toNamed('/navbar');
        } else {
          Get.snackbar(
            "Login Failed",
            "Invalid username or password",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          "Login failed",
          "An error occurred: $e",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Error", "Please fix errors",
          snackPosition: SnackPosition.TOP);
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = false;
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }
}
