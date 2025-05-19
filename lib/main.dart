import 'package:flutter/material.dart';
import 'package:shopfinity/navigation/bottom_navigation_bar.dart';
import 'package:shopfinity/theme/app_colors.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        secondary: AppColors.accentColor,
        primary: AppColors.primaryColor,
      ),
    ),
        title: 'Material App',
        home: const BottomNavBar());
  }
}
