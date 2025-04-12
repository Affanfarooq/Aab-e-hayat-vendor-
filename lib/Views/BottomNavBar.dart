import 'package:aabehayat_vendor/Controllers/BottomNavBarController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.pages[controller.selectedIndex.value],
          bottomNavigationBar: CustomBottomNavBar(),
        ));
  }
}

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});
  final BottomNavController controller = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(controller.navItems.length, (index) {
              final item = controller.navItems[index];
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

class NavItem {
  final String label;
  final String iconPath;

  NavItem(this.label, this.iconPath);
}
