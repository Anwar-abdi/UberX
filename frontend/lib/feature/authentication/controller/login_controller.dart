import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_end_points.dart';
import '../../home/screen/home_screen.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final isLoading = false.obs;
  final isPasswordObscure = true.obs;

  final formKey = GlobalKey<FormState>();

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
    );
  }

  Future<void> loginWithEmail() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(ApiEndPoints.login);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json.containsKey('token')) {
          var token = json['token'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);

          emailController.clear();
          passwordController.clear();

          debugPrint('Token: $token');

          Get.off(() => HomeScreen());
        } else {
          showSnackBar('Invalid response from server.');
        }
      } else {
        String errorMessage =
            jsonDecode(response.body)["message"] ?? "An unknown error occurred";
        showSnackBar(errorMessage);
      }
    } catch (error) {
      showSnackBar('Error: $error');
      debugPrint('Error: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
