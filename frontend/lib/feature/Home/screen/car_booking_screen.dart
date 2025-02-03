import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/booking_controller.dart';

class CarBookingWidget extends StatelessWidget {
  final String carId;
  final CarBookingController controller = Get.put(CarBookingController());

  // Call the API when the widget is created.
  CarBookingWidget({super.key, required this.carId}) {
    controller.getCarById(carId);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions from the local BuildContext.
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('Car Booking')),
      body: Obx(() {
        // If the car information is not yet available, show a loading indicator.
        if (controller.selectedCar.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Extract car data (assuming your API returns keys like "make", "model", "image", "pricePerHour").
        final car = controller.selectedCar.value;
        final double pricePerHour = (car['pricePerHour'] is num)
            ? (car['pricePerHour'] as num).toDouble()
            : 0;

        // Build the car name safely.
        final String carName = (car['make'] != null && car['model'] != null)
            ? "${car['make']} ${car['model']}"
            : "Car Name";

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the car image as a network image.
                Center(
                  child: Image.network(
                    car['image'] ?? '',
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.directions_car, size: 200);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Display the car name from the fetched data.
                Text(
                  carName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Book Car",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                RentTypeSelector(controller: controller),
                if (!controller.isSelfDriver.value)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                        "Additional \$1500 Driver Cost if You Choose With Driver Option"),
                  ),
                const SizedBox(height: 10),
                DateTimePicker(
                  label: "Pick-Up Date and Time",
                  date: controller.pickUpDate,
                  time: controller.pickUpTime,
                  onSelectDate: (date) => controller.pickUpDate.value = date,
                  onSelectTime: (time) => controller.pickUpTime.value = time,
                ),
                const SizedBox(height: 10),
                DateTimePicker(
                  label: "Return Date and Time",
                  date: controller.returnDate,
                  time: controller.returnTime,
                  onSelectDate: (date) => controller.returnDate.value = date,
                  onSelectTime: (time) => controller.returnTime.value = time,
                ),
                const SizedBox(height: 20),
                // Cost Calculation Widget:
                Obx(() {
                  double totalCost = 0;
                  if (controller.pickUpDate.value != null &&
                      controller.pickUpTime.value != null &&
                      controller.returnDate.value != null &&
                      controller.returnTime.value != null) {
                    // Combine date and time into a DateTime for start and end.
                    DateTime start = DateTime(
                      controller.pickUpDate.value!.year,
                      controller.pickUpDate.value!.month,
                      controller.pickUpDate.value!.day,
                      controller.pickUpTime.value!.hour,
                      controller.pickUpTime.value!.minute,
                    );
                    DateTime end = DateTime(
                      controller.returnDate.value!.year,
                      controller.returnDate.value!.month,
                      controller.returnDate.value!.day,
                      controller.returnTime.value!.hour,
                      controller.returnTime.value!.minute,
                    );
                    if (end.isAfter(start)) {
                      Duration duration = end.difference(start);
                      // Convert the duration to hours.
                      double hours = duration.inMinutes / 60;
                      totalCost = hours * pricePerHour;
                      if (!controller.isSelfDriver.value) {
                        totalCost += 1500;
                      }
                    }
                  }
                  return Center(
                    child: Text(
                      "Total Cost: \$${totalCost.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                // Continue Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.sendBookingRequest(carId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Obx(() => controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Continue",
                            style: TextStyle(color: Colors.white))),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class RentTypeSelector extends StatelessWidget {
  final CarBookingController controller;

  const RentTypeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => controller.toggleRentType(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.isSelfDriver.value
                    ? Colors.blue
                    : Colors.grey[300],
              ),
              child: const Text(
                "Self-Driver",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () => controller.toggleRentType(false),
              style: ElevatedButton.styleFrom(
                backgroundColor: !controller.isSelfDriver.value
                    ? Colors.blue
                    : Colors.grey[300],
              ),
              child: const Text(
                "With Driver",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateTimePicker extends StatelessWidget {
  final String label;
  final Rx<DateTime?> date;
  final Rx<TimeOfDay?> time;
  final Function(DateTime) onSelectDate;
  final Function(TimeOfDay) onSelectTime;

  const DateTimePicker({
    super.key,
    required this.label,
    required this.date,
    required this.time,
    required this.onSelectDate,
    required this.onSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) onSelectDate(pickedDate);
                  },
                  child: Text(date.value != null
                      ? DateFormat('yyyy-MM-dd').format(date.value!)
                      : "Date"),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) onSelectTime(pickedTime);
                  },
                  child: Text(time.value != null
                      ? time.value!.format(context)
                      : "Time"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
