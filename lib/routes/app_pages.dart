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
import 'package:shopfinity/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => ProductScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.productDetails,
    //   page: () => ProductDetailsScreen(product: Product product,),
    // ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartScreen(),
    ),
    GetPage(
      name: AppRoutes.delivery,
      page: () => DeliveryScreen(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => PaymentScreen(),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => CheckoutScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.addproduct,
      page: () => AddProductScreen(),
    ),
  ];
}
