import 'package:flutter/material.dart';
import 'half_circle.dart';

class HalfCircleWidget extends StatelessWidget {
  const HalfCircleWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: HalfCircleClipper(), child: child);
  }
}
