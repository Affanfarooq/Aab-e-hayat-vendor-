import 'dart:developer';

import 'package:aabehayat_vendor/Views/BottomNavBar.dart';
import 'package:aabehayat_vendor/Views/RequestApprovalScreen.dart';
import 'package:aabehayat_vendor/Views/AuthenticationScreens/LoginScreen.dart';
import 'package:aabehayat_vendor/Services/ShopService.dart';
import 'package:aabehayat_vendor/Views/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxBool isRequestApproved = false.obs;
  RxString token = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> getFCMToken() async {
    token.value = await FirebaseMessaging.instance.getToken() ?? '';
    log("FCM Token: $token");
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      isLoading.value = true;
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        Get.snackbar("Login Failed", "User not found.");
        return;
      }

      final shopData = await ShopService.getShopData(user);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isApproved = shopData?['accountApprove'] ?? false;
      await prefs.setBool("isLoggedIn", true);
      await prefs.setBool("isRequestApproved", isApproved);
      isLoading.value = false;
      if (isApproved) {
        Get.offAll(() => MainScreen());
      } else {
        Get.offAll(() => RequestApprovalScreen());
      }

    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Login Failed", e.toString());
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn.value = false;
    isRequestApproved.value = false;
    Get.offAll(() => WelcomeScreen());
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool("isLoggedIn") ?? false;
    isRequestApproved.value = prefs.getBool("isRequestApproved") ?? false;
  }

  Future<void> checkAndUpdateRequestStatus(User user) async {
    final shopData = await ShopService.getShopData(user);
    final prefs = await SharedPreferences.getInstance();
    if (shopData != null) {
      bool approved = shopData['accountApprove'] ?? false;
      isRequestApproved.value = approved;
      prefs.setBool('isRequestApproved', approved);
    }
  }
}
