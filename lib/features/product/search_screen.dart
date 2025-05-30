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
    controller.hasSearched(false); // Reset flag to avoid message before search
    super.initState();
  }

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 40,
          title: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: const ProductSearchBar(
                enabled: true,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              if (!controller.hasSearched.value) {
                return const SizedBox.shrink();
              }
              if (controller.isSearchLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.searchedProducts.isEmpty) {
                return const Expanded(
                    child: Center(
                        child: Text(
                  'Searched item not found',
                  style: TextStyle(fontSize: 16),
                )));
              }
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
