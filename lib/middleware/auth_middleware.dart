import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/login_controller.dart';

class AuthMiddleware extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route) {
    // Check if the user is logged in
    LoginController loginController = Get.put(LoginController());
    final isLoggedIn = loginController.isLoggedIn.value;

    if (!isLoggedIn && route != '/login') {
      return const RouteSettings(name: '/login');
    }

    return null;
  }
}