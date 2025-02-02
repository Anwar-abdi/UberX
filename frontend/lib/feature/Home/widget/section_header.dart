import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;

  const SectionHeader({
    super.key,
    required this.title,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final horizontalPadding = screenWidth * 0.05;
    final verticalPadding = screenHeight * 0.012;

    final titleSize = screenWidth * 0.05; // Increased title size

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: titleSize,
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}
