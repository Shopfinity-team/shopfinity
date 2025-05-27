import 'package:flutter/material.dart';
import 'package:shopfinity/routes/app_routes.dart';
import 'package:shopfinity/theme/app_colors.dart';

import '../features/auth/profile_screen.dart';
import '../features/product/cart_screen.dart';
import '../features/product/home_screen.dart';
import '../features/product/product_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<String> _routes = [
    AppRoutes.home,
    AppRoutes.categories,
    AppRoutes.cart,
    AppRoutes.profile
  ];
  final List<Widget> _screens = [
    const HomeScreen(),
    const ProductScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Get.offNamed(_routes[index]); //for navigate to corresponding name route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: AppColors.darkPrimaryColor,
            labelTextStyle:
                WidgetStateProperty.all(const TextStyle(fontSize: 0)),
            iconTheme: WidgetStateProperty.all(const IconThemeData(size: 28)),
            height: 55,
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: onItemTapped,
            backgroundColor: AppColors.dividerColor,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.home,
                    color: AppColors.icons,
                  ),
                  icon: Icon(
                    Icons.home_outlined,
                    color: AppColors.primaryText,
                  ),
                  label: ''),
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.dashboard,
                    color: AppColors.icons,
                  ),
                  icon: Icon(
                    Icons.dashboard_outlined,
                    color: AppColors.primaryText,
                  ),
                  label: ''),
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.shopping_cart,
                    color: AppColors.icons,
                  ),
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.primaryText,
                  ),
                  label: ''),
              NavigationDestination(
                  selectedIcon: Icon(
                    Icons.person,
                    color: AppColors.icons,
                  ),
                  icon: Icon(
                    Icons.perm_identity_outlined,
                    color: AppColors.primaryText,
                  ),
                  label: ''),
            ],
          ),
        ));
  }
}
