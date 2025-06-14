import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopfinity/controllers/product_controller.dart';
import 'package:shopfinity/controllers/profile_controller.dart';
import 'package:shopfinity/shared/widgets/home_screen_top_cards.dart';
import 'package:shopfinity/shared/widgets/product_card.dart';
import 'package:shopfinity/shared/widgets/search_bar.dart';
import 'package:shopfinity/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<ProductController>();

  @override
  void initState() {
    controller.getLimitProducts(); // for get limit products
    controller.getRecommendedGroceries();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.5;
    double cardHeight = screenHeight * 0.359;
    ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80.0,
          title: Image.asset('lib/assets/images/logo.png'),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.network(profileController.userProfileImage.value,
                  height: 40,                 
                  width: 40,
                  fit:  BoxFit.cover,),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  const ProductSearchBar(
                    enabled: false,
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HomeScreenTopCards(
                          cardBackground: AppColors.primaryColor,
                          cardTitle: 'Explore Latest',
                          cardSubText: 'Discover what’s new this season',
                          buttonText: 'Explore',
                          showButton: true,
                          cardImage: Image.asset(
                              'lib/assets/images/homeCardImage1.png'),
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        HomeScreenTopCards(
                          cardBackground: Color(0xFF03A9F4),
                          cardTitle: 'Deals of the Day',
                          cardSubText: 'Limited time. Unlimited style.',
                          cardImage: Image.asset(
                              'lib/assets/images/homeCardImage2.png'),
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        HomeScreenTopCards(
                          cardBackground: Color(0xFF4CAF50),
                          cardTitle: 'Style Your Space',
                          cardSubText: 'Home décor to elevate your vibe.',
                          cardImage: Image.asset(
                              'lib/assets/images/homeCardImage3.png'),
                          imageOnRight: false,
                          showButton: true,
                          buttonText: 'Categories',
                        ),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        HomeScreenTopCards(
                          cardBackground: Color(0xFF673AB7),
                          cardTitle: 'Festive Finds',
                          cardSubText: 'Celebrate in style.',
                          cardImage: Image.asset(
                              'lib/assets/images/homeCardImage4.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Most Searched Items',
                        style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Text(
                          'Show All',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    if (controller.isLimitProductsLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.limitProducts.map((product) {
                          return SizedBox(
                            height: cardHeight,
                            width: cardWidth,
                            child: ProductCard(product: product),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recommended Groceries for you',
                        style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Text(
                          'Show All',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    if (controller.isRecommendedGroceriesLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            controller.recommendedGroceries.map((product) {
                          return SizedBox(
                            height: cardHeight,
                            width: cardWidth,
                            child: ProductCard(product: product),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'New Products',
                      style: TextStyle(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Obx(() {
                    if (controller.addedProducts.isEmpty) {
                      return const Center(
                          child: Text('No new products available.'));
                    }

                    return SizedBox(
                      height: cardHeight,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.addedProducts.length,
                        itemBuilder: (context, index) {
                          final product = controller.addedProducts[index];
                          return SizedBox(
                            width: cardWidth,
                            child: ProductCard(product: product),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                      ),
                    );
                  }),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                ],
              )),
        ));
  }
}
