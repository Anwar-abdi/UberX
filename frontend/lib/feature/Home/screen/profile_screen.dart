import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentication/controller/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.find() to get the controller
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              userController.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          return Text(
            'Hello, ${userController.username.value}',
            style: TextStyle(fontSize: 24),
          );
        }),
      ),
    );
  }
}
