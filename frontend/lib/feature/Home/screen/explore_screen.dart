import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widget/loader.dart';
import '../controller/car_controller.dart';
import '../widget/car_card.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final CarController carController = Get.find();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('All Cars'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Obx(
          () => carController.cars.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: carController.cars.length,
                  itemBuilder: (context, index) => CarCard(
                    id: carController.cars[index]['_id'],
                    carName: carController.cars[index]['make'] +
                        ' ' +
                        carController.cars[index]['model'],
                    price: carController.cars[index]['pricePerHour'].toString(),
                    transmission: carController.cars[index]['transmission'],
                    fuelType: carController.cars[index]['fuelType'],
                    seats: carController.cars[index]['seats'],
                    rating: carController.cars[index]['rating'],
                    carType: "Sedan",
                    imageUrl: carController.cars[index]['image'],
                  ),
                )
              : Center(child: Loader()),
        ),
      ),
    );
  }
}
