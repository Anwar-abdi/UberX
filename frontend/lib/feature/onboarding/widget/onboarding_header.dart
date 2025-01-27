import 'package:flutter/material.dart';

import '../../../common/widget/shapes/half_circle_widget.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return HalfCircleWidget(
      child: Container(
        height: screenHeight * 0.60,
        width: double.infinity,
        color: const Color(0xFFF6F6F6),
        child: Center(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: screenWidth * 0.75,
            height: screenHeight * 1.0,
          ),
        ),
      ),
    );
  }
}
