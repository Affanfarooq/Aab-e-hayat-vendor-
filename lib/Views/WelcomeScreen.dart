import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Widgets/SpringWidget.dart';
import 'package:aabehayat_vendor/Widgets/customButton.dart';
import 'package:aabehayat_vendor/Views/authentication/widget/login_screen.dart';
import 'package:aabehayat_vendor/Views/authentication/widget/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(18),
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child:
             Image.asset(
              "assets/images/welcome.png",
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.8),
            ),

            // SvgPicture.asset(
            //   "assets/images/welcome.svg",
            //   fit: BoxFit.cover,
            // ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.withOpacity(0.6),
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 150),

                Text(
                  "Manage.\nDeliver.\nSucceed!",
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Dive Into Smart Delivery Management!",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SpringWidget(
                            onTap: () {
                              Get.to(() => LoginScreen(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 400));
                            },
                            child: CustomButton(
                              textColor: Colors.black,
                              title: "Login",
                              color: Colors.white,
                              height: 50,
                              radius: 10,
                              fontWeight: FontWeight.w500,
                              textSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: SpringWidget(
                            onTap: () {
                              Get.to(
                                () => RegistrationScreens(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 400),
                              );
                            },
                            child: CustomButton(textColor: Colors.black,
                              title: "Register Shop",
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
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login or Register your shop to get started!",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
