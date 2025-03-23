import 'dart:developer';

import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Controllers/ShopAuthController.dart';
import 'package:aabehayat_vendor/GenericWidgets/CustomIndicators.dart';
import 'package:aabehayat_vendor/GenericWidgets/WidgetsForOnBoarding.dart';
import 'package:aabehayat_vendor/GenericWidgets/customButton.dart';
import 'package:aabehayat_vendor/Views/authentication/widget/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../GenericWidgets/SpringWidget.dart';
import 'WaveAnimation.dart';

class OnBoardingScreens extends StatefulWidget {
  OnBoardingScreens({super.key}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: kPrimaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final OnboardingsController _controller = Get.put(OnboardingsController());
  final ShopAuthController shopController = Get.put(ShopAuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            WaveAnimationScreen(),
            Column(
              children: [
                Obx(() {
                  return AnimatedSwitcher(
                    duration:
                        Duration(milliseconds: 200), // Smooth transition time
                    transitionBuilder: (widget, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: widget,
                      );
                    },
                    child: _controller.currentStep.value >= 4
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 30, left: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (_controller.currentStep.value >
                                              0) {
                                            _controller.currentStep
                                                .value--; // Decrease current step
                                            _controller.pageController
                                                .previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        icon: Icon(Icons.arrow_back_ios)),
                                    Expanded(
                                        child: Obx(() => TweenAnimationBuilder(
                                              tween: Tween<double>(
                                                  begin: 0,
                                                  end: ((_controller.currentStep
                                                                  .value -
                                                              4) /
                                                          6)
                                                      .clamp(0.0,
                                                          1.0)), // Ensure value is between 0 and 1
                                              duration: Duration(
                                                  milliseconds:
                                                      500), // Animation Duration
                                              builder: (context, double value,
                                                  child) {
                                                return Container(
                                                  width: double.infinity,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .shade300, // Background Color
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds:
                                                                500), // Smooth transition
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            value,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              kPrimaryColor, // Progress Color
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: SvgPicture.asset(
                                  'assets/images/registration.svg',
                                  height: 200,
                                  fit: BoxFit.cover,
                                  key: ValueKey('onboarding1'),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                        : SizedBox(key: ValueKey('empty')),
                  );
                }),
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      PageView(
                        controller: _controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) =>
                            _controller.currentStep.value = index,
                        children: [
                          buildIntroScreen(shopController),
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
                          // buildBasicInformationForm(shopController,
                          //     heading: 'Basic information',
                          //     description:
                          //         'Please provide the basic detail of your business'),
                          // buildContactInformationForm(shopController,
                          //     heading: 'Contact information',
                          //     description:
                          //         'Provide your email and phone number for communication'),
                          // buildInventoryForm(shopController,
                          //     heading: 'Inventory information',
                          //     description:
                          //         'Enter the total gallons and bottles available with their prices.'),
                          // buildShopImagesForm(shopController,
                          //     heading: 'Upload images',
                          //     description:
                          //         'Upload images of your shop, CNIC front, and CNIC back for verification'),
                          // buildLocationForm(shopController,
                          //     heading: 'Your location',
                          //     description:
                          //         'Select your Shop location map given below'),
                          // buildDeliveryOptions(shopController,
                          //     heading: 'Delivery Schedule',
                          //     description:
                          //         'Select your delivery days and delivery time'),
                        ],
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.12,
                        left: 0,
                        right: 0,
                        child: Obx(
                          () => _controller.currentStep.value > 0 &&
                                  _controller.currentStep.value <=
                                      3 // ✅ Sirf onboarding screens ke liye
                              ? CustomProgressIndicator(
                                  totalSteps: 3, // ✅ Sirf 3 dots show karega
                                  currentStep:
                                      _controller.currentStep.value - 1,
                                )
                              : const SizedBox(), // Registration screens par indicator hide
                        ),
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
                            // Back button (Show only on second and last steps)
                            if (_controller.currentStep.value > 0)
                              Expanded(
                                child: SpringWidget(
                                  onTap: () {
                                    if (_controller.currentStep.value > 0) {
                                      _controller.currentStep
                                          .value--; // Decrease current step
                                      _controller.pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: CustomButton(
                                    title: "Back",
                                    color: Colors.white,
                                    height: 50,
                                    radius: 10,
                                    fontWeight: FontWeight.w500,
                                    textSize: 16,
                                  ),
                                ),
                              ),

                            Expanded(
                              child: Padding(
                                padding: _controller.currentStep.value > 0
                                    ? const EdgeInsets.only(left: 10)
                                    : EdgeInsets.zero,
                                child: SpringWidget(
                                  onTap: () {
                                    if (_controller.currentStep.value <
                                        _controller.totalSteps.value - 1) {
                                      _controller.currentStep.value++;
                                      log('${_controller.currentStep.value}');

                                      // This runs only if currentStep is NOT 4
                                      _controller.pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      Get.to(
                                        () => LoginScreen(),
                                        transition: Transition
                                            .rightToLeft, 
                                        duration: const Duration(
                                            milliseconds:
                                                400), 
                                      );
                                    }
                                  },
                                  child: CustomButton(
                                    title: _controller.currentStep.value == 3
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
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingsController extends GetxController {
  final PageController pageController = PageController();
  final RxInt totalSteps = 4.obs;
  final RxInt currentStep = 0.obs;
}
