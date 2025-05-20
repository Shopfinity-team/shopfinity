import 'package:flutter/material.dart';
import 'package:shopfinity/navigation/bottom_navigation_bar.dart';
import 'package:shopfinity/shared/widgets/button.dart';

import '../../theme/app_colors.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productTitleController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
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
                          "lib/assets/images/add_product_page_image.png",
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
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
                        controller: _productTitleController,
                        cursorColor: AppColors.primaryText,
                        decoration: InputDecoration(
                          labelText: "Product Title",
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
                        controller: _productDescriptionController,
                        cursorColor: AppColors.primaryText,
                        //maxLines: 2,
                        decoration: InputDecoration(
                          labelText: "Product Description",
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
                        controller: _productPriceController,
                        cursorColor: AppColors.primaryText,
                        decoration: InputDecoration(
                          labelText: "Price",
                          hintText: 'Enter price in \$ ',
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
                        controller: _productImageController,
                        cursorColor: AppColors.primaryText,
                        decoration: InputDecoration(
                          labelText: "Product Image",
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
            Button(
                text: "Save",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()));
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
