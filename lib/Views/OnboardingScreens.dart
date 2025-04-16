import 'package:aabehayat_vendor/Controllers/ShopRegistrationController.dart';
import 'package:aabehayat_vendor/Views/WaveAnimation.dart';
import 'package:aabehayat_vendor/Views/WelcomeScreen.dart';
import 'package:aabehayat_vendor/Widgets/CustomIndicators.dart';
import 'package:aabehayat_vendor/Widgets/SpringWidget.dart';
import 'package:aabehayat_vendor/Widgets/WidgetsForOnBoarding.dart';
import 'package:aabehayat_vendor/Widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final ShopRegistrationController shopController = Get.put(ShopRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: WaveAnimationScreen(
                height: 190,
              )),
          Column(
            children: [
              Obx(
                () => shopController.currentStepForOnBoardings.value > 0
                    ? Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 50),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios,
                                  color: Colors.black),
                              onPressed: () {
                                if (shopController.currentStepForOnBoardings.value > 0) {
                                  shopController.currentStepForOnBoardings.value--;
                                  shopController.pageControllerForOnBoarding.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  Get.back();
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 50),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    PageView(
                      controller: shopController.pageControllerForOnBoarding,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) =>
                          shopController.currentStepForOnBoardings.value = index,
                      children: [
                        buildStep(
                            "Effortless Water Delivery",
                            "Track all your deliveries and payments in one place, reducing the hassle and time spent on manual work. Now everything is automated and organized by AABEHAYAT!",
                            "onboarding1.svg",
                            250),
                        buildStep(
                            "Increase Your Shop's Reach",
                            "By joining our platform, your shop will be visible to more customers within a 5km radius of your shop, helping you to expand your business.",
                            "onboarding2.svg",
                            210),
                        buildStep(
                            "Boost Your Revenue",
                            "Providing your excellent service and maintaining high ratings will increase your shop’s reach, attracting more customers. You can also boost your shop to get even more visibility.",
                            "onboarding3.svg",
                            210),
                      ],
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.14,
                      left: 0,
                      right: 0,
                      child: Obx(() => CustomProgressIndicator(
                            totalSteps: shopController.totalStepsForOnBoardings.value,
                            currentStep: shopController.currentStepForOnBoardings.value,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SpringWidget(
                              onTap: () {
                                if (shopController.currentStepForOnBoardings.value <
                                    shopController.totalStepsForOnBoardings.value - 1) {
                                  shopController.currentStepForOnBoardings.value++;
                            
                                  shopController.pageControllerForOnBoarding.nextPage(
                                    duration:
                                        const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  Get.to(
                                    () => WelcomeScreen(),
                                    transition: Transition.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 400),
                                  );
                                }
                              },
                              child: CustomButton(
                                title: shopController.currentStep.value == 3
                                    ? "Continue"
                                    : "Next",
                                color: Colors.white,
                                height: 50,
                                radius: 10,
                                fontWeight: FontWeight.w500,
                                textSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              const SizedBox(height: 45),
            ],
          ),
        ],
      ),
    );
  }
}

