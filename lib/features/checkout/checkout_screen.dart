import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/cart_controller.dart';
import 'package:shopfinity/controllers/checkout_controller.dart';
import 'package:shopfinity/controllers/profile_controller.dart';
import 'package:shopfinity/features/checkout/delivery_screen.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/theme/app_colors.dart';

import '../../shared/widgets/cart_card.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController =
        Get.find(); //Access existing cart controller
    ProfileController profileController = Get.put(ProfileController());
    CheckoutController checkoutController = Get.put(CheckoutController());

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return Column(
            children: [
              cartController.cartItemCount.value == 0
                  ? Center(
                      child: Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ))
                  : ListView.builder(
                      itemCount: cartController.cartItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final product = cartController.cartItems[index];
                        return Column(
                          children: [
                            CartCard(
                              product: product,
                              isCheckout: false,
                            ),
                            const Divider(
                              color: Colors.black,
                              height: 20,
                              thickness: 1,
                            ),
                          ],
                        );
                      }),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Text(
                'Shipping Details',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Address',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    children: [
                      Text(profileController.firstName.value,
                          style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      Text(profileController.lastName.value,
                          style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: screenWidth * 0.05,
                      ),
                      Text(profileController.userPhone.value,
                          style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: Text(
                          profileController.userAddress.value,
                          style: const TextStyle(
                              color: AppColors.secondaryText, fontSize: 14),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() => DeliveryScreen());
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 15,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    'Payment Method',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Card Number: ',
                            style: TextStyle(
                                color: AppColors.secondaryText, fontSize: 14),
                          ),
                          Text(profileController.cardNumber.value,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Get.toNamed('/payment');
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 15,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      Text(
                        '\$${cartController.totalPrice.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 20.0),
        child: Button(
            text: checkoutController.isLoading.value
                ? "Placing Order..."
                : "Place Order",
            onPressed: () {
              checkoutController.processCheckout();
            }),
      ),
    );
  }
}
