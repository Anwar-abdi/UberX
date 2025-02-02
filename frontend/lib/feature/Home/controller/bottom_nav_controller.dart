import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../screen/explore_screen.dart';
import '../screen/favorite_screen.dart';
import '../screen/home_screen.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  final List<Widget> screens = [
    HomeScreen(),
    ExploreScreen(),
    FavoriteScreen(),
    // const KeyScreen(),
    // const ProfileScreen(),
  ];
}
