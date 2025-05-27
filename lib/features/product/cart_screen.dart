import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/cart_controller.dart';
import 'package:shopfinity/features/checkout/delivery_screen.dart';
import 'package:shopfinity/model/product_model.dart';
import 'package:shopfinity/shared/widgets/button.dart';

import '../../shared/widgets/cart_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Obx(() =>
          Column(
            children: [
              cartController.cartItemCount.value == 0
              ? Center(
                  child: Text(
                    "Your cart is empty",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: cartController.cartItems.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CartCard(product: cartController.cartItems[index], isCheckout: true),
                        const Divider(
                          color: Colors.black,
                          height: 20,
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total ${cartController.cartItemCount.value} items",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Obx(() =>
                    Text( 
                      "\$"+cartController.totalPrice.value.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Button(
                  text: "Checkout",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveryScreen()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
