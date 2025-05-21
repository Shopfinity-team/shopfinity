import 'package:flutter/material.dart';
import 'package:shopfinity/navigation/bottom_navigation_bar.dart';
import 'package:shopfinity/shared/widgets/button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
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
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_2_outlined),
              labelText: "Username",
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline),
              labelText: "Password",
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility_off_outlined),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.08,
          ),
          Button(
              text: "Login",
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavBar()));
              })
        ],
      ),
    ));
  }
}
