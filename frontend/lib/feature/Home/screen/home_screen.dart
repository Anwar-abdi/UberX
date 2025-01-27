import 'package:car_rental/feature/home/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    authController.checkTokenValidity();

    return Scaffold(
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
