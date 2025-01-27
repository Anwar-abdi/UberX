import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.onTap, required this.icon, required this.size});
  final void Function()? onTap;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double buttonWidth = screenWidth * 0.13;
    double buttonHeight = 34.0;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blue),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
        ),
        child: Center(
          child: Icon(
            icon,
            size: size,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
