import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfinity/features/product/home_screen.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController{
  final username = TextEditingController();
  final password = TextEditingController();
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
  if (formKey.currentState!.validate()) {
    isLoading.value = true;
    
    try {
      final response = await http.post(
        Uri.parse("https://dummyjson.com/auth/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(({
          'username': username.text,
          'password': password.text,
        })),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
          final token = data['token'];

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', token);
          await prefs.get('access_token');
          print("Token: $token");

          Get.snackbar("Success", "Logged in successfully", snackPosition: SnackPosition.BOTTOM);
          Get.offAll(() => HomeScreen());
      }else{
        // final error = jsonDecode(response.body);
        Get.snackbar(
          "error", "Invalid username or password", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          );
        // print("Error: ${error}");
      }

    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e", 
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
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