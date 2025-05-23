import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/product_controller.dart';
import 'package:shopfinity/features/auth/login_screen.dart';
import 'package:shopfinity/features/auth/profile_screen.dart';
import 'package:shopfinity/features/checkout/delivery_screen.dart';
import 'package:shopfinity/features/checkout/payment_screen.dart';
import 'package:shopfinity/features/product/cart_screen.dart';
import 'package:shopfinity/features/product/home_screen.dart';
import 'package:shopfinity/features/product/product_screen.dart';
import 'package:shopfinity/navigation/bottom_navigation_bar.dart';
import 'package:shopfinity/routes/app_pages.dart';
import 'package:shopfinity/theme/app_colors.dart';

void main() async {
  Get.put(ProductController());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
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

  @override
  Widget build(BuildContext context) {

    return BottomNavBar();
  }
}
