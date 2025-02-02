import 'package:car_rental/common/widget/loader.dart';
import 'package:car_rental/constant/images.dart';
import 'package:car_rental/feature/Home/controller/car_controller.dart';
import 'package:car_rental/feature/Home/screen/brand_info.dart';
import 'package:car_rental/feature/Home/widget/brand_card.dart';
import 'package:car_rental/feature/Home/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/car_card.dart';
import '../widget/location_input_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CarController carController = Get.put(CarController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Location Input Section
            LocationInputSection(),
            SizedBox(height: screenHeight * 0.01),
            // Section Brand Header
            SectionHeader(
              title: 'Brand',
            ),
            SizedBox(height: screenHeight * 0.005),
            // Brand List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BrandCard(
                  brandName: 'Honda',
                  image: Images.honda,
                  onTap: () => Get.to(() => BrandInfo(
                        brandName: 'Honda',
                      )),
                ),
                BrandCard(
                    brandName: 'Audi',
                    image: Images.audi,
                    onTap: () => Get.to(() => BrandInfo(
                          brandName: 'Audi',
                        ))),
                BrandCard(
                    brandName: 'Nissan',
                    image: Images.nissan,
                    onTap: () => Get.to(() => BrandInfo(
                          brandName: 'Nissan',
                        ))),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            // Section Popular Car Header
            SectionHeader(
              title: 'Popular Car',
            ),
            SizedBox(height: screenHeight * 0.005),
            // Popular Car List
            Obx(
              () => carController.cars.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (carController.cars.length + 3) -
                          carController.cars.length,
                      itemBuilder: (context, index) => CarCard(
                        id: carController.cars[index]['_id'],
                        carName: carController.cars[index]['make'] +
                            ' ' +
                            carController.cars[index]['model'],
                        price: carController.cars[index]['pricePerHour']
                            .toString(),
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
          ],
        ),
      ),
    );
  }
}
