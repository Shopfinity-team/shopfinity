import 'package:get/get.dart';
import 'package:shopfinity/features/auth/login_screen.dart';
import 'package:shopfinity/features/auth/profile_screen.dart';
import 'package:shopfinity/features/checkout/checkout_screen.dart';
import 'package:shopfinity/features/checkout/delivery_screen.dart';
import 'package:shopfinity/features/checkout/payment_screen.dart';
import 'package:shopfinity/features/product/add_product_screen.dart';
import 'package:shopfinity/features/product/cart_screen.dart';
import 'package:shopfinity/features/product/home_screen.dart';
import 'package:shopfinity/features/product/product_screen.dart';
import 'package:shopfinity/features/product/search_screen.dart';
import 'package:shopfinity/middleware/auth_middleware.dart';
import 'package:shopfinity/navigation/bottom_navigation_bar.dart';
import 'package:shopfinity/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => ProductScreen(),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartScreen(),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: AppRoutes.delivery,
      page: () => DeliveryScreen(),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => PaymentScreen(),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => CheckoutScreen(),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: AppRoutes.addproduct,
      page: () => AddProductScreen(),
      middlewares: [AuthMiddleware()]
    ),

    GetPage(
      name: AppRoutes.search, 
      page: () => SearchScreen(),
      middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: '/navbar',
      page: () => BottomNavBar(),
      middlewares: [AuthMiddleware()]
    )

  ];
}
