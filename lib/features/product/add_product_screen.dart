import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/product_controller.dart';
import 'package:shopfinity/features/product/new_products_screen.dart';
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter product image url';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              InputField(
                                labelText: "Product Description",
                                controller: _productDescriptionController,
                                validator: (value) {
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
              Button(
                  text: "Save",
                  onPressed: () async {
                    if (addProductFormKey.currentState!.validate()) {
                      final price =
                          double.tryParse(_productPriceController.text.trim());
                      if (price == null) {
                        print('enter valid price');
                        return;
                      }
                      final product = Product(
                          title: _productTitleController.text.trim(),
                          price: price,
                          description:
                              _productDescriptionController.text.trim(),
                          imageUrl: _productImageController.text
                                  .trim()
                                  .isNotEmpty
                              ? _productImageController.text.trim()
                              : 'https://cdn.dummyjson.com/product-images/furniture/annibale-colombo-bed/thumbnail.webp');

                      final result = await controller.addProduct(product);

                      if (result != null) {
                        Get.to(() => NewProductsScreen(
                            products: [Product.fromJson(result)]));
                        print('new product added successfully');
                      } else {
                        print('failed to add new product');
                      }
                    } else {
                      print('Form is not valid');
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
