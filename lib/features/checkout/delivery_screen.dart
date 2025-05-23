import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/features/checkout/payment_screen.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/shared/widgets/checkoutInputField.dart';

class DeliveryScreen extends StatefulWidget {
  DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Delivery",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                            "lib/assets/images/delivery_page_image.png",
                          ),
                        ),
                        Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              InputField(
                                controller: _countryController,
                                labelText: 'country',
                                hintText: 'Select Country',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    showCountryPicker(
                                        context: context,
                                        onSelect: (Country country) {
                                          setState(() {
                                            _countryController.text =
                                                country.name;
                                          });
                                        });
                                  },
                                  icon: const Icon(Icons.arrow_drop_down),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '* Please select country';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                controller: _districtController,
                                labelText: 'District',
                                validator: (value) {
                                  if (_countryController.text == 'Sri Lanka') {
                                    if (value == null || value.isEmpty) {
                                      return '* Please enter district';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: 'Street',
                                controller: _streetController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '* Please enter street';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: 'City',
                                controller: _cityController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '* Please enter city';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: 'Postal Code',
                                controller: _postalCodeController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '* Please enter postal code';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                            ],
                          ),
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
                    if (formKey.currentState!.validate()) {
                      Get.to(() => PaymentScreen());
                    } else {
                      print('form is not valid');
                    }
                  }),
              SizedBox(
                height: screenHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
