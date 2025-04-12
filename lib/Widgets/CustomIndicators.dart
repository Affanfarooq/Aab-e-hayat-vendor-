import 'package:aabehayat_vendor/Utils/DesignConstants.dart';
import 'package:flutter/material.dart';

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
