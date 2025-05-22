import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryButton({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor: Color(0xFFD9D9D9),
            elevation: 0,
          ),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
