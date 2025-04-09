import 'dart:developer';
import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Controllers/ShopAuthController.dart';
import 'package:aabehayat_vendor/Widgets/CustomLoading.dart';
import 'package:aabehayat_vendor/Widgets/SpringWidget.dart';
import 'package:aabehayat_vendor/Widgets/WidgetsForOnBoarding.dart';
import 'package:aabehayat_vendor/Widgets/customButton.dart';
import 'package:aabehayat_vendor/Views/WaveAnimation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreens extends StatefulWidget {
  @override
  State<RegistrationScreens> createState() => _RegistrationScreensState();
}

class _RegistrationScreensState extends State<RegistrationScreens> {
  final ShopAuthController _controller = Get.find<ShopAuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 15, left: 5, bottom: 5, top: 3),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: kTextColor),
                        onPressed: () {
                          if (_controller.currentStep.value > 0) {
                            _controller.currentStep.value--;
                            _controller.pageControllerForRegister.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Get.back();
                          }
                        },
                      ),
                      Expanded(
                        child: Obx(() {
                          int totalSteps = _controller.totalSteps.value;
                          int currentStep = _controller.currentStep.value;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(totalSteps, (index) {
                              bool isActive = index <= currentStep;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width:
                                    (MediaQuery.of(context).size.width - 80) /
                                        totalSteps,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? kPrimaryColor
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              );
                            }),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      PageView(
                        controller: _controller.pageControllerForRegister,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) =>
                            _controller.currentStep.value = index,
                        children: [
                          buildBasicInformationForm(_controller,
                              heading: 'Basic information',
                              description:
                                  'Please provide the basic detail of your business'),
                          buildContactInformationForm(_controller,
                              heading: 'Contact information',
                              description:
                                  'Provide your email and phone number for communication'),
                          buildInventoryForm(_controller,
                              heading: 'Inventory information',
                              description:
                                  'Enter the total gallons and bottles available with their prices.'),
                          buildShopImagesForm(_controller,
                              heading: 'Upload images',
                              description:
                                  'Upload images of your shop, CNIC front, and CNIC back for verification'),
                          buildLocationForm(_controller,
                              heading: 'Shop location',
                              description:
                                  'Select your shop location from the map below.'),
                          buildDeliveryOptions(_controller,
                              heading: 'Delivery Schedule',
                              description:
                                  'Select the days and times you deliver.'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Stack(
                  children: [
                    WaveAnimationScreen(height: 130),
                    Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SpringWidget(
                                  onTap: () {
                                    bool isValid = _controller.authtentication(
                                        _controller.currentStep.value, context);

                                    if (isValid) {
                                      if (_controller.currentStep.value <
                                          _controller.totalSteps.value - 1) {
                                        _controller.currentStep.value++;
                                        log('${_controller.currentStep.value}');

                                        _controller.pageControllerForRegister
                                            .nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      } else {
                                        log("Registration completed");
                                      }
                                    }
                                  },
                                  child: CustomButton(
                                    title: _controller.currentStep.value == 6
                                        ? "Continue"
                                        : "Next",
                                    color: Colors.white,
                                    height: 55,
                                    radius: 12,
                                    fontWeight: FontWeight.w500,
                                    textSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
            Obx(() {
              if (_controller.isLoading.value) {
                Future.delayed(Duration.zero, () {
                  if (!Get.isDialogOpen!) {
                    Get.dialog(
                      const CustomLoadingDialog(),
                      barrierDismissible: false,
                    );
                  }
                });
              } else {
                if (Get.isDialogOpen!) {
                  Get.back();
                }
              }
              return const SizedBox.shrink();
            }),
          ],
        ));
  }
}
