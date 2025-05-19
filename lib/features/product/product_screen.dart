import 'package:flutter/material.dart';
import 'package:shopfinity/shared/widgets/category_buton.dart';
import 'package:shopfinity/shared/widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              SearchBar(
                hintText: "Search for products",
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                children: [
                  for(int i = 0; i < 5; i++)
                    CategoryButton(title: "beauty"),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
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
                itemCount: 8,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    title: "Essence Mascara Lash Princess", 
                    imageUrl: "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp", 
                    price: 9.99
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
