import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 51.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.icons,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 0.4)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search Shopfinity',
                        hintStyle: TextStyle(color: AppColors.accentColor),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    cursorColor: AppColors.primaryText,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.accentColor,
                        )))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
