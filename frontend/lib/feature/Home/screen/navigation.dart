import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_nav_controller.dart';

class Navigation extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.currentIndex.value]),
    );
  }
}
