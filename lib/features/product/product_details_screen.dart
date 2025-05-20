import 'package:flutter/material.dart';
import 'package:shopfinity/features/product/cart_screen.dart';
import 'package:shopfinity/model/product.dart';
import 'package:shopfinity/shared/widgets/button.dart';
import 'package:shopfinity/theme/app_colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Product Detail',
          style: TextStyle(color: AppColors.primaryText),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(child: Image.network(product.imageUrl)),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Text(
                      product.title,
                      style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  Text(
                    "\$" + product.price.toString(),
                    style: const TextStyle(
                        color: AppColors.darkPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xFFFFCC00),
                  ),
                  //Text(product.productRate.toString())
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '4.94',
                      style: TextStyle(
                          color: AppColors.secondaryText, fontSize: 14),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Text(
                'Product Description',
                style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              //Text(product.description ?? 'no description'),
              const Text(
                'The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.',
                style: TextStyle(
                  color: Color(0xFF706D6D),
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.06,
              ),
              Center(
                  child: Button(
                      text: 'Buy Now',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()));
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
