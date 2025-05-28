import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/delivery_controller.dart';
import 'package:shopfinity/features/checkout/checkout_screen.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/shared/widgets/checkout_input_field.dart';

class DeliveryScreen extends StatefulWidget {
  DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final DeliveryController deliveryController = Get.put(DeliveryController());

  late final TextEditingController _countryController;
  late final TextEditingController _addressController;
  late final TextEditingController _aptController;
  late final TextEditingController _provinceController;
  late final TextEditingController _districtController;
  late final TextEditingController _townController;
  late final TextEditingController _postalCodeController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _countryController = TextEditingController(text: deliveryController.country.value);
    _addressController = TextEditingController(text: deliveryController.address.value);
    _aptController = TextEditingController();
    _provinceController = TextEditingController(text: deliveryController.state.value);
    _districtController = TextEditingController(text: deliveryController.city.value);
    _townController = TextEditingController();
    _postalCodeController = TextEditingController(text: deliveryController.postalCode.value);
  }

  @override
  void dispose() {
    // Don't forget to dispose controllers
    _countryController.dispose();
    _addressController.dispose();
    _aptController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _townController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  // The missing method that was causing the error
  void _saveDeliveryDetails() {
    if (formKey.currentState!.validate()) {
      // Update the delivery controller with new values
      deliveryController.country.value = _countryController.text;
      deliveryController.address.value = _addressController.text;
      deliveryController.state.value = _provinceController.text;
      deliveryController.city.value = _districtController.text;
      deliveryController.postalCode.value = _postalCodeController.text;
      
      // Show success message
      Get.snackbar(
        'Success',
        'Delivery details saved successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      // Navigate back or to checkout screen
      Get.back();
      // Or navigate to checkout: Get.to(() => CheckoutScreen());
    }
  }

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
                              TextFormField(
                                controller: _countryController,
                                readOnly: true, // Make it read-only since it's selected via picker
                                decoration: InputDecoration(
                                  labelText: 'Country*',
                                  hintText: 'Select Country',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      showCountryPicker(
                                        context: context,
                                        onSelect: (Country country) {
                                          setState(() {
                                            _countryController.text = country.name;
                                          });
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_drop_down),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select country';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              TextFormField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  labelText: 'Street/house/apartment/unit*',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              TextFormField(
                                controller: _aptController,
                                decoration: const InputDecoration(
                                  labelText: 'Apt/suite, unit, etc (optional)',
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              TextFormField(
                                controller: _provinceController,
                                decoration: const InputDecoration(
                                  labelText: 'Province',
                                ),
                                validator: (value) {
                                  if (_countryController.text == 'Sri Lanka') {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter province';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              TextFormField(
                                controller: _districtController,
                                decoration: const InputDecoration(
                                  labelText: 'District',
                                ),
                                validator: (value) {
                                  if (_countryController.text == 'Sri Lanka') {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter district';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              TextFormField(
                                controller: _townController,
                                decoration: const InputDecoration(
                                  labelText: 'Area/Town*',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter city';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              TextFormField(
                                controller: _postalCodeController,
                                decoration: const InputDecoration(
                                  labelText: 'ZIP code*',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a ZIP/postal code';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        )
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
                onPressed: _saveDeliveryDetails,
              ),
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