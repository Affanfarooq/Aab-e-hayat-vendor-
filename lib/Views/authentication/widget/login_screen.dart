import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Controllers/OnBoardingController.dart';
import 'package:aabehayat_vendor/GenericWidgets/SpringWidget.dart';
import 'package:aabehayat_vendor/GenericWidgets/WidgetsForOnBoarding.dart';
import 'package:aabehayat_vendor/GenericWidgets/customButton.dart';
import 'package:aabehayat_vendor/Views/OnboardingScreens.dart';
import 'package:aabehayat_vendor/Views/WaveAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(OnboardingsController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Positioned.fill(child: WaveAnimationScreen(currentStep: 0., heightFactor: 0.9)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/login.svg',
                    fit: BoxFit.cover,
                    height: 190,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kTextColor),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Please enter your credentials to access your account.',
                      style:
                          GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildInputField(emailController, "Email", icon: 'email.svg'),
                  SizedBox(
                    height: 10,
                  ),
                  buildInputField(passWordController, "Password",
                      icon: 'password.svg'),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SpringWidget(
                          onTap: () {},
                          child: CustomButton(
                            title: "Login",
                            color: kPrimaryColor,
                            height: 50,
                            radius: 10,
                            fontWeight: FontWeight.w500,
                            textSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                    SizedBox(
                    height: 20,
                  ),
                  Text(
                    'If you are not registered on our platform',
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade400),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Register',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
