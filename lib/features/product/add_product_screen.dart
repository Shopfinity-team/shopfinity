import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/product_controller.dart';
import 'package:shopfinity/model/product_model.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/shared/widgets/checkout_input_field.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = Get.find<ProductController>();

  final TextEditingController _productTitleController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productImageController = TextEditingController();

  final addProductFormKey = GlobalKey<FormState>();
  bool submitted = false;

  void onSave() async {
    submitted = true;
    if (addProductFormKey.currentState!.validate()) {
      final price = double.tryParse(_productPriceController.text.trim());
      if (price == null) {
        Get.snackbar('Error', 'please enter valid price',
            backgroundColor: Colors.red);
        return;
      }
      final product = Product(
          title: _productTitleController.text.trim(),
          price: price,
          description: _productDescriptionController.text.trim(),
          imageUrl: _productImageController.text.trim().isNotEmpty
              ? _productImageController.text.trim()
              : 'https://i.imgur.com/sUFH1Aq.png');

      final result = await controller.addProduct(product);

      if (result != null) {
        Get.snackbar('Success', 'New product added successfully.',
            backgroundColor: Colors.green);

        _productTitleController.clear();
        _productPriceController.clear();
        _productImageController.clear();
        _productDescriptionController.clear();

        submitted = false;
      } else {
        Get.snackbar('Error', 'Failed to add new product',
            backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar('Error', 'Form is not valid', backgroundColor: Colors.red);
    }
  }

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
                        Form(
                          key: addProductFormKey,
                          child: Column(
                            children: [
                              InputField(
                                labelText: "Product Title",
                                controller: _productTitleController,
                                validator: (value) {
                                  if (!submitted) return null;
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter product title';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: "Price",
                                controller: _productPriceController,
                                hintText: 'Enter price in \$ ',
                                validator: (value) {
                                  if (!submitted) return null;
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter product price';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: "Product Image",
                                controller: _productImageController,
                                hintText: 'Enter image url',
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: "Product Description",
                                controller: _productDescriptionController,
                                validator: (value) {
                                  if (!submitted) return null;
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter product description';
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
              Button(text: "Save", onPressed: onSave),
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
