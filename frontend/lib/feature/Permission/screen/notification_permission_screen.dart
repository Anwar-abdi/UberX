import 'package:flutter/material.dart';

import '../widget/permission_request.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PermissionRequestPage(
        icon: Icons.notifications_active,
        title: 'Enable Notifications',
        description: 'Receive important updates and alerts',
        buttonText: 'Allow Notifications',
        onPressed: () {},
      ),
    );
  }
}
