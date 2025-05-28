import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/features/checkout/checkout_screen.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/shared/widgets/checkout_input_field.dart';

class DeliveryScreen extends StatefulWidget {
  DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aptController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit shipping address",
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
                                labelText: 'Country*',
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
                                    return 'Please select country';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: 'Street/house/apartment/unit*',
                                controller: _addressController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: 'Apt/suite,unit,etc (optional)',
                                controller: _aptController,
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                controller: _provinceController,
                                labelText: 'Province',
                                validator: (value) {
                                  if (_countryController.text == 'Sri Lanka') {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter province';
                                    }
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
                                      return 'Please enter district';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: 'Area/Town*',
                                controller: _townController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter city';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: 'ZIP code*',
                                controller: _postalCodeController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a ZIP/postal code';
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
                  text: "Save",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Get.to(() => CheckoutScreen());
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
