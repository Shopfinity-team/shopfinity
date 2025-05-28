import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/category_controller.dart';
import 'package:shopfinity/shared/widgets/categories.dart';
import 'package:shopfinity/shared/widgets/category_buton.dart';
import 'package:shopfinity/shared/widgets/product_card.dart';
import 'package:shopfinity/shared/widgets/search_bar.dart';

import '../../model/product_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    CategoryController categoryController = Get.put(CategoryController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.06,
              ),
              ProductSearchBar(
                enabled: false,
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
                SizedBox(
                  height: screenHeight * 0.1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Categories.categories.length,
                    itemBuilder: (context, index) {
                      return Obx(() =>
                        SizedBox(
                          width: screenWidth * 0.215,
                          child: CategoryButton(
                            title: Categories.categories[index]['title'],
                            icon: Categories.categories[index]['icon'],
                            onPressed: () {
                              categoryController.selectCategory(index);
                            },
                            selectedCategoryIndex:
                                categoryController.selectedCategoryIndex.value,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Obx(() =>
                Text(
                  categoryController.selectedCategory.value + " Products",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GetBuilder<CategoryController>(
                builder: (controller) {
                  if (controller.isLoading.value) {
                    return Column(
                      children: [
                        SizedBox(height: screenHeight * 0.1),
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  } else if (controller.products.isEmpty) {
                    return Center(child: Text("No products found."));
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: screenHeight * 0.02,
                      crossAxisSpacing: screenWidth * 0.02,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: controller.products[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
