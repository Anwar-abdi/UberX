import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_end_points.dart';
import '../screen/login_screen.dart';

class UserController extends GetxController {
  final username = ''.obs;

  @override
  onInit() {
    super.onInit();
    setUsername();
  }

  void setUsername() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? userId = prefs.getString('userId');
      if (userId != null) {
        http.Response response = await http.get(
          Uri.parse('${ApiEndPoints.user}/$userId'),
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          username.value = data['name'];
        } else {
          debugPrint('Failed to load user data');
        }
      } else {
        debugPrint('No userId found in SharedPreferences');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('userId');
    await prefs.remove('token');

    Get.offAll(() => LoginScreen());
  }
}
