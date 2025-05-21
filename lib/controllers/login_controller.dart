import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/features/product/home_screen.dart';

class LoginController extends GetxController{
  final username = TextEditingController();
  final password = TextEditingController();
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
  if (formKey.currentState!.validate()) {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2)); 

    isLoading.value = false;
    Get.snackbar("Success", "Logged in successfully", snackPosition: SnackPosition.BOTTOM);
    Get.offAll(() => HomeScreen());
  } else {
    Get.snackbar("Error", "Please fix errors", snackPosition: SnackPosition.BOTTOM);
  }
}


   @override
  void onClose() {
    username.dispose();
    password.dispose();
    super.onClose();
  }

}