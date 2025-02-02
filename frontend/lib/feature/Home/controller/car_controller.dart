import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../api_end_points.dart';

class CarController extends GetxController {
  var cars = <dynamic>[].obs;
  var filteredCars = <dynamic>[].obs;
  var favoritedCarIds = <String>[].obs;
  var favoritedCars = <dynamic>[].obs;

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

        final List<dynamic> availableCars =
            decodedData.where((car) => car['available'] == true).toList();

        cars.assignAll(availableCars);
        filteredCars.assignAll(availableCars);
        updateFavoritedCars();
        debugPrint('Successfully loaded available cars');
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

  void favoriteCar(String id) {
    if (favoritedCarIds.contains(id)) {
      favoritedCarIds.remove(id);
    } else {
      favoritedCarIds.add(id);
    }
    updateFavoritedCars();
  }

  bool isFavorite(String id) {
    return favoritedCarIds.contains(id);
  }

  void resetFilter() {
    filteredCars.assignAll(cars);
  }

  void updateFavoritedCars() {
    favoritedCars.assignAll(
        cars.where((car) => favoritedCarIds.contains(car['_id'])).toList());
  }
}
