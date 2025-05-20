import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:shopfinity/shared/widgets/button.dart';

import '../../theme/app_colors.dart';

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
                      TextField(
                        controller: _countryController,
                        cursorColor: AppColors.primaryText,
                        decoration: InputDecoration(
                            labelText: "Country",
                            hintText: 'Select Country',
                            labelStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ),
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.primaryText, width: 1)),
                            suffixIcon: IconButton(
                              onPressed: () {
                                showCountryPicker(
                                    context: context,
                                    onSelect: (Country country) {
                                      setState(() {
                                        _countryController.text = country.name;
                                      });
                                    });
                              },
                              icon: Icon(Icons.arrow_drop_down),
                            )),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      TextField(
                        controller: _districtController,
                        cursorColor: AppColors.primaryText,
                        decoration: InputDecoration(
                          labelText: "District",
                          //hintText: 'Enter Country',
                          labelStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primaryText, width: 1)),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      TextField(
                        controller: _streetController,
                        cursorColor: AppColors.primaryText,
                        decoration: InputDecoration(
                          labelText: "Street",
                          //hintText: 'Enter Country',
                          labelStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primaryText, width: 1)),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      TextField(
                        controller: _cityController,
                        cursorColor: AppColors.primaryText,
                        decoration: InputDecoration(
                          labelText: "City",
                          //hintText: 'Enter Country',
                          labelStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primaryText, width: 1)),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      TextField(
                        controller: _postalCodeController,
                        cursorColor: AppColors.primaryText,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Postal Code",
                          //hintText: 'Enter Country',
                          labelStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.primaryText, width: 1)),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Button(text: "Next", onPressed: () {}),
            SizedBox(
              height: screenHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
