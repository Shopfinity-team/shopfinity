import 'package:flutter/material.dart';
import 'package:shopfinity/shared/widgets/category_buton.dart';
import 'package:shopfinity/shared/widgets/product_card.dart';
import 'package:shopfinity/shared/widgets/search_bar.dart';

import '../../model/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
              ProductSearchBar(),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < 10; i++)
                      SizedBox(
                        width: screenWidth * 0.2,
                        child: CategoryButton(title: "Category $i"),
                      ),
                  ],
                ),
              ),
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
