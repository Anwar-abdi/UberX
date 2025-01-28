import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final String carName;
  final String price;
  final String transmission;
  final String location;
  final int seats;
  final double rating;

  const CarCard({
    Key? key,
    required this.carName,
    required this.price,
    required this.transmission,
    required this.location,
    required this.seats,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              carName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Price: $price/hr'),
            Text('Transmission: $transmission'),
            Text('Location: $location'),
            Text('Seats: $seats'),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(rating.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
