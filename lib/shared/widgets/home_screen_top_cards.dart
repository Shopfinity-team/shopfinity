import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class HomeScreenTopCards extends StatelessWidget {
  final String cardTitle;
  final String cardSubText;
  final String buttonText;
  final Image cardImage;
  final bool showButton;
  final Color cardBackground;
  final bool imageOnRight;

  const HomeScreenTopCards({
    super.key,
    required this.cardTitle,
    required this.cardSubText,
    this.buttonText = '',
    required this.cardImage,
    this.showButton = false,
    required this.cardBackground,
    this.imageOnRight = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double cardWidth = screenWidth * 0.8;
    double cardHeight = screenHeight * 0.22;
    double titleTextFontSize = screenWidth * 0.06;
    double subTextFontSize = screenWidth * 0.04;

    return Row(
      children: [
        Container(
          height: cardHeight,
          width: cardWidth,
          decoration: BoxDecoration(
              color: cardBackground, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 10.0),
            child: imageOnRight
                ? Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cardTitle,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: titleTextFontSize,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              cardSubText,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: subTextFontSize,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            if (showButton)
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryText,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    buttonText,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: subTextFontSize,
                                    ),
                                  )),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: cardImage),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(flex: 1, child: cardImage),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cardTitle,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: titleTextFontSize,
                                  fontWeight: FontWeight.w600),
                            ),
                            //const SizedBox(height: 10.0),
                            Text(
                              cardSubText,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: subTextFontSize,
                              ),
                            ),
                            //const SizedBox(height: 10.0),
                            if (showButton)
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryText,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Text(
                                      buttonText,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: subTextFontSize,
                                      ),
                                    )),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        )
      ],
    );
  }
}
