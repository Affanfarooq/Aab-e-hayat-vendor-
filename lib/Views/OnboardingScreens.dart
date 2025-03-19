import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/GenericWidgets/CustomButton.dart';
import 'package:aabehayat_vendor/GenericWidgets/SpringWidget.dart';
import 'package:aabehayat_vendor/Views/ShopRegistration.dart';
import 'package:aabehayat_vendor/Views/WaveAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final PageController _pageController = PageController();
  final int _totalSteps = 4; // Updated total steps
  final RxInt _currentStep = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          WaveAnimationScreen(currentStep: _currentStep),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) => _currentStep.value = index,
                        children: [
                          _buildIntroScreen(),
                          _buildStep(
                              "Effortless Water Delivery",
                              "Track all your deliveries and payments in one place, reducing the hassle and time spent on manual work. Now everything is automated and organized by AABEHAYAT!",
                              "onboarding1.svg",
                              250),
                          _buildStep(
                              "Increase Your Shop's Reach",
                              "By joining our platform, your shop will be visible to more customers within a 5km radius of your shop, helping you to expand your business.",
                              "onboarding2.svg",
                              210),
                          _buildStep(
                              "Boost Your Revenue",
                              "Providing your excellent service and maintaining high ratings will increase your shop’s reach, attracting more customers. You can also boost your shop to get even more visibility.",
                              "onboarding3.svg",
                              210),
                        ],
                      ),
                      Positioned(
                        bottom: 120,
                        left: 0,
                        right: 0,
                        child: Obx(
                          () => _currentStep.value >
                                  0 
                              ? CustomProgressIndicator(
                                  totalSteps: _totalSteps -
                                      1, 
                                  currentStep: _currentStep.value -
                                      1,
                                )
                              : SizedBox(), 
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
                            if (_currentStep.value > 0)
                              Expanded(
                                child: SpringWidget(
                                  onTap: () {
                                    _pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: CustomButton(
                                    title: "Back",
                                    color: Colors.white,
                                    height: 50,
                                    radius: 10,
                                    fontWeight: FontWeight.bold,
                                    textSize: 16,
                                  ),
                                ),
                              ),

                            Expanded(
                              child: Padding(
                                padding: _currentStep.value > 0
                                    ? const EdgeInsets.only(left: 10)
                                    : EdgeInsets.zero,
                                child: SpringWidget(
                                  onTap: () {
                                    if (_currentStep.value == 0) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    } else if (_currentStep.value <
                                        _totalSteps - 1) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      Get.to(() => ShopRegistrationScreen(),
                                          transition: Transition.rightToLeft,
                                          duration: const Duration(
                                              milliseconds: 500));
                                    }
                                  },
                                  child: CustomButton(
                                    title: _currentStep.value == 0
                                        ? "Get Started"
                                        : (_currentStep.value == _totalSteps - 1
                                            ? "Continue"
                                            : "Next"),
                                    color: Colors.white,
                                    height: 50,
                                    radius: 10,
                                    fontWeight: FontWeight.bold,
                                    textSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // New first screen with logo
  Widget _buildIntroScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 130),
              SvgPicture.asset('assets/images/splash.svg', height: 130),
              SizedBox(height: 20),
              Text(
                "AABEHAYAT",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "Aapki zarrorat hamari zimydari",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.grey,fontWeight: FontWeight.w600),
              ),
            ],
          ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 40,),
             child: Text(
                  "Managing your water supply, made easy.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w600),
                ),
           ),
        ],
      ),
    );
  }

  Widget _buildStep(
      String heading, String description, String image, double imageSize) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/$image',
              height: imageSize,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 50),
            Text(
              heading,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
            ),
            const SizedBox(height: 15),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: kLightGreyTextColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const CustomProgressIndicator({
    Key? key,
    required this.totalSteps,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: index == currentStep ? 25 : 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: currentStep == index ? kPrimaryColor : kSecondaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}
