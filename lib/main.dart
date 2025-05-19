import 'package:flutter/material.dart';
import 'package:shopfinity/shared/widgets/product_card.dart';
import 'package:shopfinity/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.darkPrimaryColor,
        primaryColorLight: AppColors.lightPrimaryColor,
        dividerColor: AppColors.dividerColor,
        iconTheme: const IconThemeData(
          color: AppColors.icons,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.primaryText),
          bodySmall: TextStyle(color: AppColors.secondaryText),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          secondary: AppColors.accentColor,
          primary: AppColors.primaryColor,  
          ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopfinity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProductCard(
              title: "Essence Mascara Lash Princess", 
              imageUrl:  "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp", 
              price: 9.99,
              )
          ]
        ),
      ),
    );
  }
}
