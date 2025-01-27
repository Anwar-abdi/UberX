import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelText extends StatelessWidget {
  const LabelText({
    super.key,
    required this.screenHeight,
    required this.text,
  });

  final double screenHeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: screenHeight * 0.02,
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      ),
    );
  }
}
