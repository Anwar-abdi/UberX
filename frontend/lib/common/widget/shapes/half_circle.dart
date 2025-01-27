import 'package:flutter/cupertino.dart';

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 70);

    // Deeper curve from the left to the right
    path.quadraticBezierTo(
      size.width / 2, // Control point X (center of the width)
      size.height + 50, // Control point Y (increase for deeper curve)
      size.width, // End point X (right corner)
      size.height - 70, // End point Y
    );

    // Line to the top-right corner
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
