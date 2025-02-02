import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widget/loader.dart';
import '../controller/car_controller.dart';
import '../widget/car_card.dart';

class BrandInfo extends StatelessWidget {
  BrandInfo({super.key, required this.brandName});
  final String brandName;

  final CarController carController = Get.find<CarController>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    // Call filtering outside build method
    WidgetsBinding.instance.addPostFrameCallback((_) {
      carController.filterCars(brandName);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(brandName),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            carController.resetFilter();
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Obx(
          () => carController.filteredCars.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: carController.filteredCars.length,
                  itemBuilder: (context, index) {
                    final car = carController.filteredCars[index];
                    return CarCard(
                      carName: "${car['make']} ${car['model']}",
                      price: car['pricePerHour'].toString(),
                      transmission: car['transmission'],
                      fuelType: car['fuelType'],
                      seats: car['seats'],
                      rating: car['rating'],
                      carType: "Sedan",
                      imageUrl: car['image'],
                    );
                  },
                )
              : const Center(child: Loader()),
        ),
      ),
    );
  }
}
