import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental/feature/home/controller/auth_controller.dart';
import '../widget/brand_card.dart'; // Import the reusable brand card widget
import '../widget/car_card.dart'; // Import the reusable car card widget
import '../widget/bottom_navigation_bar.dart'; // Import the reusable bottom navigation bar

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    authController.checkTokenValidity();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Rental'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brands Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Brands',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  BrandCard(brandName: 'Honda', imagePath: 'assets/honda.png'),
                  BrandCard(brandName: 'Mason', imagePath: 'assets/mason.png'),
                  BrandCard(brandName: 'Audi', imagePath: 'assets/audi.png'),
                  BrandCard(
                      brandName: 'Mercedes', imagePath: 'assets/mercedes.png'),
                ],
              ),
            ),

            // Popular Cars Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Cars',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ],
              ),
            ),
            const CarCard(
              carName: 'Hyundai Verna',
              price: 'Rs.500/hr',
              transmission: 'Manual',
              location: 'Pariol',
              seats: 5,
              rating: 4.9,
            ),
            const CarCard(
              carName: 'Honda Civic',
              price: 'Rs.600/hr',
              transmission: 'Automatic',
              location: 'Downtown',
              seats: 5,
              rating: 4.8,
            ),
            // Add more CarCard widgets here
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0, // Set the index for the Home screen
        onTap: (index) {
          // Handle navigation to other screens
          if (index == 1) {
            Get.toNamed('/explore'); // Navigate to Explore screen
          } else if (index == 2) {
            Get.toNamed('/favorites'); // Navigate to Favorites screen
          } else if (index == 3) {
            Get.toNamed('/key'); // Navigate to Key screen
          } else if (index == 4) {
            Get.toNamed('/profile'); // Navigate to Profile screen
          }
        },
      ),
    );
  }
}
