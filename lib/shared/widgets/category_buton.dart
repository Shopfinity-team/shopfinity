import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/shared/widgets/categories.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final int selectedCategoryIndex;
  final void Function()? onPressed;

  const CategoryButton({super.key, required this.title, required this.icon, required this.selectedCategoryIndex, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final int index = Categories.categories.indexWhere((category) => category['title'] == title);
    RxBool isSelected = false.obs;
    isSelected.value = selectedCategoryIndex == index;

    return Obx(() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: isSelected.value ? Theme.of(context).colorScheme.primary : Color(0xFFD9D9D9),
                elevation: 0,
              ),
              child: Icon(
                icon,
                color: isSelected.value ? Colors.white : Colors.black,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected.value ? Theme.of(context).colorScheme.primary : Colors.black,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
