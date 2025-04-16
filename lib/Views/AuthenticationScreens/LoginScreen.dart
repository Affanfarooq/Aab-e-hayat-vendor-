import 'dart:ui';

import 'package:aabehayat_vendor/Controllers/LoginController.dart';
import 'package:aabehayat_vendor/Controllers/ShopRegistrationController.dart';
import 'package:aabehayat_vendor/Utils/DesignConstants.dart';
import 'package:aabehayat_vendor/Views/AuthenticationScreens/RegistrationScreen.dart';
import 'package:aabehayat_vendor/Widgets/CustomTextField.dart';
import 'package:aabehayat_vendor/Widgets/SpringWidget.dart';
import 'package:aabehayat_vendor/Widgets/customButton.dart';
import 'package:aabehayat_vendor/Views/WaveAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              forceMaterialTransparency: true,
              backgroundColor: Colors.white,
              
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 80,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
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
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildInputField(emailController, "Email",
                              icon: 'email.svg'),
                          SizedBox(height: 10),
                          buildInputField(passWordController, "Password",
                              icon: 'password.svg'),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SpringWidget(
                                  onTap: () {
                                    loginController.loginWithEmailPassword(
                                      emailController.text,
                                      passWordController.text,
                                    );
                                  },
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
                          SizedBox(height: 20),
                          Text(
                            'If you are not registered on our platform',
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.grey.shade400),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          SpringWidget(
                            onTap: () {
                              Get.put(ShopRegistrationController());
                              Get.to(() => RegistrationScreen());
                            },
                            child: Text(
                              'Register',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: WaveAnimationScreen(height: 100),
          ),

          // 🔥 Full-screen loading overlay with blur
          if (loginController.isLoading.value)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Center(
                    child: CircularProgressIndicator(color: kPrimaryColor,),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
