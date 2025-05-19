import 'package:flutter/material.dart';
import 'package:shopfinity/features/product/cart_screen.dart';
import 'package:shopfinity/features/product/home_screen.dart';
import 'package:shopfinity/features/product/product_screen.dart';
import 'package:shopfinity/features/product/profile_screen.dart';
import 'package:shopfinity/theme/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ProductScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: AppColors.darkPrimaryColor,
              labelTextStyle:
                  WidgetStateProperty.all(const TextStyle(fontSize: 0))),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
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
                  selectedIcon: Icon(Icons.dashboard, color: AppColors.icons),
                  icon: Icon(Icons.dashboard_outlined,
                      color: AppColors.primaryText),
                  label: ''),
              NavigationDestination(
                  selectedIcon:
                      Icon(Icons.shopping_cart, color: AppColors.icons),
                  icon: Icon(Icons.shopping_cart_outlined,
                      color: AppColors.primaryText),
                  label: ''),
              NavigationDestination(
                  selectedIcon: Icon(Icons.person, color: AppColors.icons),
                  icon: Icon(Icons.perm_identity_outlined,
                      color: AppColors.primaryText),
                  label: ''),
            ],
          ),
        ));
  }
}
