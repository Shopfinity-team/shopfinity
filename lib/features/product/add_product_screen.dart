import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/product_controller.dart';
import 'package:shopfinity/model/product_model.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/shared/widgets/checkout_input_field.dart';
import 'package:shopfinity/shared/widgets/custom_alert.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = Get.find<ProductController>();

  final TextEditingController _productTitleController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  final addProductFormKey = GlobalKey<FormState>();
  bool submitted = false;

  // handle save
  Future<void> onSave() async {
    submitted = true;
    if (addProductFormKey.currentState!.validate()) {
      final price = double.tryParse(_productPriceController.text.trim());
      if (price == null) {
        await showCustomAlert(
          title: 'Error',
          message: 'Please enter a valid price',
          isError: true,
        );
        return;
      }

      final product = Product(
        title: _productTitleController.text.trim(),
        price: price,
        description: _productDescriptionController.text.trim(),
        imageUrl: controller.getImagePathOrDefault(),
      );

      final result = await controller.addProduct(product);

      if (result != null) {
        await showCustomAlert(
          title: 'Success',
          message: 'New product added successfully',
        );
        _productTitleController.clear();
        _productPriceController.clear();
        _productDescriptionController.clear();
        controller.resetPickedImage();
        submitted = false;
      } else {
        await showCustomAlert(
          title: 'Error',
          message: 'Failed to add new product',
          isError: true,
        );
      }
    } else {
      await showCustomAlert(
        title: 'Error',
        message: 'Form is not valid',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              final pickedImage = controller.pickedImage.value;
              return GestureDetector(
                onTap: () => controller.pickImage(),
                child: Container(
                  height: screenHeight * 0.25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                  ),
                  child: pickedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            pickedImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image, size: 40, color: Colors.grey),
                              Text("Tap to pick an image"),
                            ],
                          ),
                        ),
                ),
              );
            }),
            SizedBox(height: screenHeight * 0.03),
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
                  SizedBox(height: screenHeight * 0.02),
                  InputField(
                    labelText: "Price",
                    controller: _productPriceController,
                    hintText: 'Enter price in \$',
                    validator: (value) {
                      if (!submitted) return null;
                      if (value == null || value.isEmpty) {
                        return 'Please enter product price';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Button(text: "Save", onPressed: onSave),
          ],
        ),
      ),
    );
  }
}
