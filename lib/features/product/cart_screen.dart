import 'package:flutter/material.dart';
import 'package:shopfinity/features/checkout/delivery_screen.dart';
import 'package:shopfinity/model/product.dart';
import 'package:shopfinity/shared/widgets/button.dart';

import '../../shared/widgets/cart_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
        child: Column(
          children: [
            ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = Product(
                      title: "Essence Mascara Lash Princess",
                      imageUrl:
                          "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp",
                      price: 9.99,
                      quantity: 5,
                      description:
                          "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.");
                  return Column(
                    children: [
                      CartCard(product: product),
                      Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 1,
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total (3 items):",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "\$125.99",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
    );
  }
}
