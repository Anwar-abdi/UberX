import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_end_points.dart';

class CarBookingController extends GetxController {
  RxBool isSelfDriver = true.obs;
  Rx<DateTime?> pickUpDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> pickUpTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> returnDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> returnTime = Rx<TimeOfDay?>(null);
  RxBool isLoading = false.obs;
  var selectedCar = Rxn<dynamic>();

  void toggleRentType(bool selfDrive) {
    isSelfDriver.value = selfDrive;
  }

  Future<void> sendBookingRequest(String carId) async {
    if (pickUpDate.value == null ||
        pickUpTime.value == null ||
        returnDate.value == null ||
        returnTime.value == null) {
      Get.snackbar("Error", "Please select all date and time fields.");
      return;
    }

    // Combine date and time into proper DateTime objects.
    final DateTime startDateTime = DateTime(
      pickUpDate.value!.year,
      pickUpDate.value!.month,
      pickUpDate.value!.day,
      pickUpTime.value!.hour,
      pickUpTime.value!.minute,
    );
    final DateTime endDateTime = DateTime(
      returnDate.value!.year,
      returnDate.value!.month,
      returnDate.value!.day,
      returnTime.value!.hour,
      returnTime.value!.minute,
    );

    // Retrieve the auth token from SharedPreferences using the key "token"
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null || token.isEmpty) {
      Get.snackbar("Error", "Authentication token not found.");
      return;
    }

    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse("${ApiEndPoints.api}/api/bookings"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "user": prefs.getString("userId"),
          "car": carId,
          "startDate": startDateTime.toIso8601String(),
          "endDate": endDateTime.toIso8601String(),
          "rentType": isSelfDriver.value ? "self-drive" : "with-driver",
        }),
      );

      final data = json.decode(response.body);
      if (response.statusCode == 201) {
        Get.snackbar("Success", "Booking request sent successfully!");
      } else {
        debugPrint('Failed to send booking request: $data');
        Get.snackbar(
            "Error", data['message'] ?? "Failed to send booking request.");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCarById(String id) async {
    try {
      final response = await http.get(Uri.parse("${ApiEndPoints.car}/$id"));
      if (response.statusCode == 200) {
        selectedCar.value = json.decode(response.body);
        debugPrint('Successfully fetched car details');
      } else {
        debugPrint('Failed to fetch car: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching car: $e');
    }
  }
}
