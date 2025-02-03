import 'dart:ui' as ui;
import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Views/ShopRegistration.dart';
import 'package:aabehayat_vendor/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../GenericWidgets/CustomDesign/circle_design.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final PageController _pageController = PageController();
  final int _totalSteps = 3;
  final RxInt _currentStep = 0.obs;

  @override
  Widget build(BuildContext context) {
    double width = ScreenHelper.getScreenWidth(context);
    double height = ScreenHelper.getScreenHeight(context);
    return Scaffold(
      floatingActionButton: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_currentStep.value > 0)
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  backgroundColor: kPrimaryColor,
                  shape: CircleBorder(),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            SizedBox(width: 10),
            if (_currentStep.value < _totalSteps - 1)
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  shape: CircleBorder(),
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            if (_currentStep.value == _totalSteps - 1)
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    Get.to(()=>ShopRegistrationScreen());
                  },
                  backgroundColor: Colors.green.shade600,
                  shape: CircleBorder(),
                  child: Icon(Icons.check, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          CustomPaint(
            size: ui.Size(width, (height * 0.7665350318471338).toDouble()),
            painter: CircleDesign(),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) => _currentStep.value = index,
                    children: [
                      _buildStep(
                        "Effortless Water Delivery",
                        "Track all your deliveries and payments in one place, reducing the hassle and time spent on manual work. Now everything is automated and organized by aabehayat!",
                        "Animation6.json",
                      ),
                      _buildStep(
                        "Increase Your Shop's Reach",
                        "By joining our platform, your shop will be visible to more customers within a 5km radius of your shop, helping you to expand your business.",
                        "Animation4.json",
                      ),
                      _buildStep(
                        "Boost Your Revenue",
                        "Providing your excellent service and maintaining high ratings will increase your shop’s reach, attracting more customers. You can also boost your shop to get even more visibility.",
                        "Animation7.json",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: _buildCustomProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String heading, String description, String image) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/$image',
              height: 320,
              fit: BoxFit.cover,
            ),
            image!='Animation7.json'?const SizedBox(height: 20):const SizedBox(height: 0),
            Text(
              heading,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kTextColor),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kLightGreyTextColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _totalSteps,
        (index) => Obx(
          () => Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentStep.value == index
                  ? kPrimaryColor
                  : Colors.blue.shade200,
            ),
          ),
        ),
      ),
    );
  }
}
