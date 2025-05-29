import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/features/product/search_screen.dart';

import '../../controllers/product_controller.dart';
import '../../theme/app_colors.dart';

class ProductSearchBar extends StatefulWidget {
  final bool enabled;

  const ProductSearchBar({super.key, required this.enabled});

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  final controller = Get.find<ProductController>();

  final TextEditingController _searchInputController = TextEditingController();

  void onSearchChanged(String value) {
    if (value.isEmpty) {
      controller.searchedProducts.clear();
      controller.update();
    } else {
      controller.searchProducts(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.enabled) {
          Get.to(() => const SearchScreen());
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 51.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.icons,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10, top: 5),
                child: Icon(
                  Icons.search_rounded,
                  color: AppColors.accentColor,
                ),
              ),
              Expanded(
                child: AbsorbPointer(
                  absorbing: !widget.enabled,
                  child: TextField(
                    controller: _searchInputController,
                    onChanged: onSearchChanged,
                    enabled: widget.enabled,
                    decoration: const InputDecoration(
                        hintText: 'Search Products',
                        hintStyle: TextStyle(color: AppColors.accentColor),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    cursorColor: AppColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
