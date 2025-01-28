import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandCard extends StatelessWidget {
  final String brandName;
  final String image;
  final Color borderColor;
  final Color backgroundColor;
  final Color iconColor;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  const BrandCard({
    super.key,
    required this.brandName,
    required this.image,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final cardSize = screenWidth * 0.15;
    final imageSize = cardSize * 0.9;
    final fontSize = screenWidth * 0.04;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: cardSize,
            height: cardSize,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                image,
                width: imageSize,
                height: imageSize,
                color: iconColor,
              ),
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            brandName,
            style: textStyle ??
                GoogleFonts.poppins(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
