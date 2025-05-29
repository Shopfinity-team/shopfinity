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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    DeliveryController deliveryController = Get.put(DeliveryController());

    TextEditingController _countryController = TextEditingController(text: deliveryController.country);
    TextEditingController _addressController = TextEditingController(text: deliveryController.address);
    TextEditingController _aptController = TextEditingController();
    TextEditingController _provinceController = TextEditingController(text: deliveryController.state);
    TextEditingController _districtController = TextEditingController();
    TextEditingController _townController = TextEditingController(text: deliveryController.city);
    TextEditingController _postalCodeController = TextEditingController(text: deliveryController.postalCode);

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
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _countryController,
                                readOnly: true, 
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
                                  labelText: 'Province/State*',
                                ),
                                validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter province/State';
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
                                  labelText: 'Postal/ZIP code*',
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
                onPressed: () {
                  deliveryController.updateAddress(
                    _countryController.text,
                    _addressController.text,
                    _aptController.text,                   
                    _districtController.text,
                    _townController.text,
                    _provinceController.text,
                    _postalCodeController.text,
                  );
                },
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