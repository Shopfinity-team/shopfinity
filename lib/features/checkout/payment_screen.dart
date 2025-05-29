import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/payment_controller.dart';
import 'package:shopfinity/features/checkout/checkout_screen.dart';
import 'package:shopfinity/shared/widgets/button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    PaymentController paymentController = Get.put(PaymentController());

    TextEditingController nameController = TextEditingController(text: paymentController.nameOnCard); 
    TextEditingController cardNumberController = TextEditingController(text: paymentController.cardNumber);
    TextEditingController expiryDateController = TextEditingController(text: paymentController.expiryDate);
    TextEditingController cvvController = TextEditingController(text: paymentController.cvv );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit payment details",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
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
                          TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name on Card",
                        labelStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter name on card' : null,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: cardNumberController,
                      decoration: InputDecoration(
                        labelText: "Card Number",
                        labelStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter card number' : null,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: expiryDateController,
                            decoration: InputDecoration(
                              labelText: "Expiry Date",
                              labelStyle: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter expiry date'
                                : null,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.1),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: cvvController,
                            decoration: InputDecoration(
                              labelText: "CVV",
                              labelStyle: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                              ),
                            ),
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Enter CVV' : null,
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
                  height: screenHeight * 0.2,
                ),
                Button(
                    text: "Save",
                    onPressed: () {
                      paymentController.updatePaymentDetails(
                        nameController.text, 
                        cardNumberController.text, 
                        expiryDateController.text, 
                        cvvController.text,
                      );
                    }),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
