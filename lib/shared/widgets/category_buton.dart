import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;

  const CategoryButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {}, 
          child: Icon(
            Icons.title,
            color: Colors.black,
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        Text(
          title,
        )
      ],
    );
  }
}