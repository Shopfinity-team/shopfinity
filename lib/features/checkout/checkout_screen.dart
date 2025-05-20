import 'package:flutter/material.dart';
import 'package:shopfinity/model/product.dart';
import 'package:shopfinity/navigation/bottom_navigation_bar.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/theme/app_colors.dart';

import '../../shared/widgets/cart_card.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(20.0),
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
                      CartCard(
                        product: product,
                        isCheckout: true,
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
                Row(
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
                Row(
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
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    Text(
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
                Row(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()));
                })
          ],
        ),
      ),
    );
  }
}
