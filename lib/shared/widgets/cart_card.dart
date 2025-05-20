import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;
  final String description;

  const CartCard({super.key, 
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double cardWidth = screenWidth * 0.9;
    double cardHeight = screenHeight * 0.3;
    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: cardWidth * 0.3,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$$price',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: (){}, 
                              icon: Icon(Icons.remove, 
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                              size: 16,
                              )
                            ),
                            Text('$quantity'),
                            IconButton(
                              onPressed: (){}, 
                              icon: Icon(Icons.add, 
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                              size: 16,
                              )
                            ),
                          ],
                        )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}