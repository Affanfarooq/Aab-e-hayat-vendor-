import 'package:aabehayat_vendor/Controllers/AuthController.dart';
import 'package:aabehayat_vendor/Views/BottomNavBar.dart';
import 'package:aabehayat_vendor/Views/BottomNavBarScreens/Dashboard.dart';
import 'package:aabehayat_vendor/Views/BottomNavBarScreens/Delivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    Dashboard(),
    DeliveryScreen(),
    Center(child: Text("Payments Screen")),
    Center(
        child: IconButton(
      icon: Icon(Icons.logout),
      onPressed: () {
        Get.find<AuthController>().logout();
      },
    )),
  ];

  final List<NavItem> navItems = [
    NavItem("Dashboard", "assets/images/dashboard_icon.svg"),
    NavItem("Delivery", "assets/images/delivery_icon.svg"),
    NavItem("Payments", "assets/images/payment_icon.svg"),
    NavItem("Profile", "assets/images/profile_icon.svg"),
  ];
}
