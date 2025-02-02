import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/feature/Home/controller/car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CarCard extends StatelessWidget {
  final String carName;
  final String price;
  final String transmission;
  final String fuelType;
  final int seats;
  final double rating;
  final String carType;
  final String imageUrl;
  final String id;

  const CarCard({
    super.key,
    required this.carName,
    required this.price,
    required this.transmission,
    required this.fuelType,
    required this.seats,
    required this.rating,
    required this.carType,
    required this.imageUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final cardWidth = screenWidth * 0.9;
    final CarController carController = Get.find<CarController>();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                /// Car Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: screenWidth * 0.4,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, size: 50, color: Colors.red),
                  ),
                ),

                /// Rating Badge
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(
                              1), // Ensures a consistent format
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Favorite Button (Properly Positioned)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Obx(() => InkWell(
                        onTap: () {
                          carController.favoriteCar(id);
                        },
                        child: Icon(
                          carController.isFavorite(id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 24,
                        ),
                      )),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// **Car Type Label**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                carType,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),

            /// **Car Name & Price**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      carName,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '\$ $price/hr',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// **Features (Transmission, Fuel, Seats) - Icons in a Row**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureIconText(
                      icon: Icons.directions_car, text: transmission),
                  FeatureIconText(
                      icon: Icons.local_gas_station, text: fuelType),
                  FeatureIconText(icon: Icons.event_seat, text: '$seats Seats'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// **Reusable Feature Row (Icons beside the text)**
class FeatureIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureIconText({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
