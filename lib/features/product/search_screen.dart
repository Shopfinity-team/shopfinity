import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/shared/widgets/product_card.dart';
import 'package:shopfinity/shared/widgets/search_bar.dart';

import '../../controllers/product_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    controller.searchedProducts.clear();
    super.initState();
  }

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.5;
    double cardHeight = screenHeight * 0.359;
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 40,
          title: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ProductSearchBar(
                enabled: true,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: GridView.builder(
                  itemCount: controller.searchedProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 6.0,
                      childAspectRatio: 0.59),
                  itemBuilder: (context, index) {
                    final product = controller.searchedProducts[index];
                    return ProductCard(product: product);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
