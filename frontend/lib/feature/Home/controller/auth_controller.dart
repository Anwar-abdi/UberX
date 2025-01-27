import 'package:car_rental/feature/authentication/screen/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  Future<void> checkTokenValidity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null || JwtDecoder.isExpired(token)) {
      await prefs.remove('token');
      _showExpiredTokenDialog();
    }
  }

  void _showExpiredTokenDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Session Expired',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Your session has expired. Please log in again to continue using the app.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.offAll(() => LoginScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
