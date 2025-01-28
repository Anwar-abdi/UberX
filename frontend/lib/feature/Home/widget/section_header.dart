import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onAction;
  final TextStyle? titleStyle;
  final TextStyle? actionStyle;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText = 'See all',
    required this.onAction,
    this.titleStyle,
    this.actionStyle,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final horizontalPadding = screenWidth * 0.05;
    final verticalPadding = screenHeight * 0.012;

    final titleSize = screenWidth * 0.05; // Increased title size
    final actionSize = screenWidth * 0.038;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          InkWell(
            onTap: onAction,
            borderRadius: BorderRadius.circular(screenWidth * 0.015),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.012),
              child: Text(
                actionText,
                style: actionStyle ??
                    GoogleFonts.poppins(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: actionSize,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
