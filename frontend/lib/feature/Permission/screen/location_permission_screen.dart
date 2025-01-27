import 'package:flutter/material.dart';

import '../widget/permission_request.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PermissionRequestPage(
        icon: Icons.location_on,
        title: 'What is Your Location?',
        description: 'We need to know your location in order to suggest',
        buttonText: 'Allow Location Access',
        onPressed: () {},
      ),
    );
  }
}
