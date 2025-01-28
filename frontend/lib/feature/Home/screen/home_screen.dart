import 'package:car_rental/constant/images.dart';
import 'package:car_rental/feature/Home/widget/brand_card.dart';
import 'package:car_rental/feature/Home/widget/section_header.dart';
import 'package:flutter/material.dart';
import '../widget/car_card.dart';
import '../widget/custom_bottom_navigation_bar.dart';
import '../widget/location_input_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              onAction: () {},
            ),
            SizedBox(height: screenHeight * 0.005),
            // Brand List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BrandCard(brandName: 'Honda', image: Images.honda),
                BrandCard(brandName: 'Audi', image: Images.audi),
                BrandCard(brandName: 'Mercedes', image: Images.mercedes),
                BrandCard(brandName: 'Nissan', image: Images.nissan),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            // Section Popular Car Header
            SectionHeader(
              title: 'Popular Car',
              onAction: () {},
            ),
            SizedBox(height: screenHeight * 0.005),
            CarCard(
              carName: "Hyundai Verna",
              price: "500",
              transmission: "Manual",
              fuelType: "Petrol",
              seats: 5,
              rating: 4.9,
              carType: "Sedan",
              imageUrl: Images.huanda,
              isFavorite: true,
            ),
            SizedBox(height: screenHeight * 0.005),
            CarCard(
              carName: "Hyundai Verna",
              price: "500",
              transmission: "Manual",
              fuelType: "Petrol",
              seats: 5,
              rating: 4.9,
              carType: "Sedan",
              imageUrl: Images.huanda,
              isFavorite: true,
            ),
            SizedBox(height: screenHeight * 0.005),
            CarCard(
              carName: "Hyundai Verna",
              price: "500",
              transmission: "Manual",
              fuelType: "Petrol",
              seats: 5,
              rating: 4.9,
              carType: "Sedan",
              imageUrl: Images.huanda,
              isFavorite: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
