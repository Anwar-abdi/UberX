import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingText extends StatelessWidget {
  final String mainText;
  final String emphasizedText;
  final Color mainColor;
  final Color emphasizedColor;
  final EdgeInsets? padding;

  const OnboardingText({
    super.key,
    required this.mainText,
    required this.emphasizedText,
    this.padding,
    required this.mainColor,
    required this.emphasizedColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.poppins(
          fontSize: screenHeight * 0.030,
          color: mainColor,
        ),
        text: mainText,
        children: [
          TextSpan(
            text: emphasizedText,
            style: GoogleFonts.poppins(
              fontSize: screenHeight * 0.030,
              color: emphasizedColor,
            ),
          ),
        ],
      ),
    );
  }
}
