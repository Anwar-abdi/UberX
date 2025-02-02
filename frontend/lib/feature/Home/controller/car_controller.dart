import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../api_end_points.dart';

class CarController extends GetxController {
  var cars = <dynamic>[].obs;
  var filteredCars = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllCars();
  }

  Future<void> getAllCars() async {
    try {
      final response = await http.get(Uri.parse(ApiEndPoints.car));

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        cars.assignAll(decodedData);
        filteredCars.assignAll(decodedData); // Initially, show all cars
        debugPrint('Successfully loaded cars');
      } else {
        debugPrint('Failed to load cars: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching cars: $e');
    }
  }

  void filterCars(String brand) {
    filteredCars.assignAll(cars.where((car) => car['make'] == brand).toList());
  }

  void resetFilter() {
    filteredCars.assignAll(cars);
  }
}
