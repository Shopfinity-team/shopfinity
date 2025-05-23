import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/category_controller.dart';
import 'package:shopfinity/shared/widgets/categories.dart';
import 'package:shopfinity/shared/widgets/category_buton.dart';
import 'package:shopfinity/shared/widgets/product_card.dart';
import 'package:shopfinity/shared/widgets/search_bar.dart';

import '../../model/product_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Categories categories = Categories();
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
                    itemCount: categories.categories.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: screenWidth * 0.215,
                        child: CategoryButton(
                          title: categories.categories[index]['title'],
                          icon: categories.categories[index]['icon'],
                          controller: categoryController,
                          index: categories.categories[index]['index'],
                        ),
                      );
                    },
                  ),
                ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Obx(() =>
              //     Row(
              //         children: [
              //           for (final category in categories.categories)
              //             SizedBox(
              //               width: screenWidth * 0.215,
              //               child: CategoryButton(title: category['title'], icon: category['icon'], controller: categoryController, index: category['index'],),
              //             ),
              //         ],
              //       ),
              //   ),
              // ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Text(
                "Beauty Products",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Disable inner scrolling
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: screenHeight * 0.02,
                  crossAxisSpacing: screenWidth * 0.02,
                  childAspectRatio:
                      0.6, // Adjust this based on your ProductCard layout
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                      product: Product(
                    imageUrl:
                        "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp",
                    title: "Essence Mascara Lash Princess",
                    price: 9.99,
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
