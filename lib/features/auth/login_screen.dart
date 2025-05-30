import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/login_controller.dart';
import 'package:shopfinity/shared/widgets/button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "lib/assets/images/login_page_logo.png",
                height: screenHeight * 0.1,
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: screenHeight * 0.04,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.08,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2_outlined),
                  labelText: "Username",
                ),
                controller: controller.username,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "*Please enter username";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Obx(
                () => TextFormField(
                  obscureText:
                      controller.isPasswordVisible.value ? false : true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        controller.togglePasswordVisibility();
                      },
                    ),
                  ),
                  controller: controller.password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*Please enter password";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.08,
              ),
              Obx(
                () => Button(
                    text: controller.isLoading.value ? "Loading..." : "Login",
                    onPressed: controller.login),
              )
            ],
          ),
        ),
      ),
    );
  }
}
