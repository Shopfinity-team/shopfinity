import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/cart_controller.dart';
import 'package:shopfinity/navigation/bottom_navigation_bar.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/theme/app_colors.dart';

import '../../shared/widgets/cart_card.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController =
        Get.find(); //Access existing cart controller
    double screenHeight = MediaQuery.of(context).size.height;

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
        padding: EdgeInsets.all(20.0),
        child: Obx(() {
          return Column(
            children: [
              cartController.cartItems.value == 0
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
                      physics: NeverScrollableScrollPhysics(),
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
                'Summary',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Name: ',
                        style: TextStyle(
                            color: AppColors.secondaryText, fontSize: 12),
                      ),
                      Text('John Doe',
                          style: TextStyle(
                              color: AppColors.secondaryText, fontSize: 12))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Payment Method',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Card Number: ',
                        style: TextStyle(
                            color: AppColors.secondaryText, fontSize: 12),
                      ),
                      Text('1212 1212 1212',
                          style: TextStyle(
                              color: AppColors.secondaryText, fontSize: 12))
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount: ',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      const Text(
                        '\$125.99',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Delivery',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Address: ',
                        style: TextStyle(
                            color: AppColors.secondaryText, fontSize: 12),
                      ),
                      Text('90090, Hapugala,Wakwella, Galle, Srilanka',
                          style: TextStyle(
                              color: AppColors.secondaryText, fontSize: 12))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.08,
              ),
              Button(
                  text: "Add Order",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavBar()));
                  })
            ],
          );
        }),
      ),
    );
  }
}
