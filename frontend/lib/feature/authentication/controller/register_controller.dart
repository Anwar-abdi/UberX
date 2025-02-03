import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../api_end_points.dart';
import '../../home/screen/home_screen.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final isLoading = false.obs;
  final isPasswordObscure = true.obs;

  void togglePasswordVisibility() {
    isPasswordObscure.toggle();
  }

  void showSnackBar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
    );
  }

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(ApiEndPoints.register);
      Map<String, dynamic> body = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'phone': phoneController.text.trim()
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      var responseJson = jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (responseJson.containsKey('token')) {
          var token = responseJson['token'];
          var userId = responseJson['userId'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          await prefs.setString('userId', userId);

          nameController.clear();
          emailController.clear();
          passwordController.clear();
          phoneController.clear();

          debugPrint('Token: $token');

          Get.off(() => HomeScreen());
        } else {
          showSnackBar('Invalid response from server.');
        }
      } else {
        String errorMessage =
            responseJson["message"] ?? "An unknown error occurred";
        showSnackBar(errorMessage);
        debugPrint('Error: $errorMessage');
      }
    } catch (error) {
      showSnackBar('Error: $error');
      debugPrint('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
