import 'package:car_rental/feature/onboarding/screen/onboarding_screen.dart';
import 'package:car_rental/feature/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/Home/screen/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');

  runApp(App(initialRoute: await determineInitialRoute(token, prefs)));
}

Future<Widget> determineInitialRoute(
    String? token, SharedPreferences prefs) async {
  if (token == null || token.isEmpty) {
    return Navigation();
  } else {
    return Navigation();
  }
}

class App extends StatelessWidget {
  final Widget initialRoute;

  const App({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      debugShowCheckedModeBanner: false,
      home: initialRoute,
    );
  }
}
