import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/car_controller.dart';
import '../widget/car_card.dart';
import '../widget/custom_bottom_navigation_bar.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final CarController carController = Get.find();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Favorite Cars'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Obx(
          () => carController.favoritedCars.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: carController.favoritedCars.length,
                  itemBuilder: (context, index) => CarCard(
                    onTap: () {},
                    id: carController.favoritedCars[index]['_id'],
                    carName: carController.favoritedCars[index]['make'] +
                        ' ' +
                        carController.favoritedCars[index]['model'],
                    price: carController.favoritedCars[index]['pricePerHour']
                        .toString(),
                    transmission: carController.favoritedCars[index]
                        ['transmission'],
                    fuelType: carController.favoritedCars[index]['fuelType'],
                    seats: carController.favoritedCars[index]['seats'],
                    rating:
                        carController.favoritedCars[index]['rating'].toString(),
                    carType: "Sedan",
                    imageUrl: carController.favoritedCars[index]['image'],
                  ),
                )
              : Center(
                  child: Text(
                    'No favorite cars yet!',
                  ),
                ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
