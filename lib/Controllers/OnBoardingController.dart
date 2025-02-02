import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage {
  final String imageAsset;
  final String title;
  final String description;

  OnboardingPage({
    required this.imageAsset,
    required this.title,
    required this.description,
  });
}

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt selectedPageIndex = 0.obs;

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      imageAsset: 'assets/onboarding1.png',
      title: 'Welcome to App',
      description: 'This is the first onboarding screen.',
    ),
    OnboardingPage(
      imageAsset: 'assets/onboarding2.png',
      title: 'Explore Features',
      description: 'This is the second onboarding screen.',
    ),
    OnboardingPage(
      imageAsset: 'assets/onboarding3.png',
      title: 'Get Started',
      description: 'This is the third onboarding screen.',
    ),
  ];

  void completeOnboarding() {
    // Save the onboarding completion status
    // For example, using SharedPreferences
    Get.offAllNamed('/home'); // Navigate to home screen
  }
}