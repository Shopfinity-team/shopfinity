import 'package:flutter/material.dart';
import 'package:shopfinity/features/auth/login_screen.dart';
import 'package:shopfinity/features/checkout/payment_screen.dart';
import 'package:shopfinity/features/product/cart_screen.dart';
import 'package:shopfinity/features/product/product_screen.dart';
import 'package:shopfinity/features/product/profile_screen.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/shared/widgets/cart_card.dart';
import 'package:shopfinity/shared/widgets/product_card.dart';
import 'package:shopfinity/navigation/bottom_navigation_bar.dart';
import 'package:shopfinity/theme/app_colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.darkPrimaryColor,
        primaryColorLight: AppColors.lightPrimaryColor,
        dividerColor: AppColors.dividerColor,
        iconTheme: const IconThemeData(
          color: AppColors.icons,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.primaryText),
          bodySmall: TextStyle(color: AppColors.secondaryText),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          secondary: AppColors.accentColor,
          primary: AppColors.primaryColor,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void onPressed() {
    // Handle button press
    print("Button pressed");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

        return ProfileScreen();
  }
}
