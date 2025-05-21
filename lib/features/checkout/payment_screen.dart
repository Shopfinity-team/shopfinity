import 'package:flutter/material.dart';
import 'package:shopfinity/features/checkout/checkout_screen.dart';
import 'package:shopfinity/shared/widgets/button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          "lib/assets/images/payment_page_image.png",
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Name on Card",
                          labelStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Card Number",
                          labelStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Expiry Date",
                                labelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "CVV",
                                labelStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Button(
                text: "Next",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckoutScreen()));
                }),
            SizedBox(
              height: screenHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
