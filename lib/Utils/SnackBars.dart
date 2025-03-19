import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtils {
  static void showSuccess(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }

  static void showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(10),
      borderRadius: 8,
      icon: Icon(Icons.error, color: Colors.white),
    );
  }
}
