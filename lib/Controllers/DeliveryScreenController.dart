import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Map<String, String>> users = [
    {'name': 'Umar Jahangir', 'location': 'Gulshan-e-Iqbal block-2'},
    {'name': 'Ahmed Ali', 'location': 'Gulshan-e-Iqbal block-2'},
    {'name': 'Sufiyan Mukeem', 'location': 'Gulshan-e-Iqbal block-2'},
    {'name': 'Sameena Sajjad', 'location': 'Gulshan-e-Iqbal block-2'},
  ];

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
