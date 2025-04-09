import 'package:aabehayat_vendor/Views/Dashboard.dart';
import 'package:aabehayat_vendor/Views/DeliveryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    Dashboard(),
    DeliveryScreen(),
    Center(child: Text("Payments Screen")),
    Center(child: Text("Profile Screen")),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[controller.selectedIndex.value],
          bottomNavigationBar: CustomBottomNavBar(),
        ));
  }
}





class CustomBottomNavBar extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<_NavItem> navItems = [
    _NavItem("Dashboard", "assets/images/dashboard_icon.svg"),
    _NavItem("Delivery", "assets/images/delivery_icon.svg"),
    _NavItem("Payments", "assets/images/payment_icon.svg"),
    _NavItem("Profile", "assets/images/profile_icon.svg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15,left: 5,right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isSelected = controller.selectedIndex.value == index;
              final color = isSelected ? Colors.blue : Colors.grey;
          
              return GestureDetector(
                onTap: () => controller.changeTab(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      item.iconPath,
                      height: 22,
                      color: color,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.label,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String iconPath;

  _NavItem(this.label, this.iconPath);
}

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
