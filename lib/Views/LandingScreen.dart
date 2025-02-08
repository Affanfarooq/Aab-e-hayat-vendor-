import 'dart:ui' as ui;
import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/Views/OnboardingScreens.dart';
import 'package:aabehayat_vendor/Views/ShopRegistration.dart';
import 'package:aabehayat_vendor/utils/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../GenericWidgets/CustomDesign/circle_design.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    double width = ScreenHelper.getScreenWidth(context);
    double height = ScreenHelper.getScreenHeight(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          CustomPaint(
            size: ui.Size(width, (height * 0.7665350318471338).toDouble()),
            painter: CircleDesign(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Image.asset(
                      //       "assets/images/gallon.png",
                      //       height: 70,
                      //       color: Colors.blue.shade100,
                      //     ),
                      //     Image.asset(
                      //       "assets/images/bottle.png",
                      //       height: 70,
                      //       color: Colors.blue.shade100,
                      //     ),
                      //   ],
                      // ),

                      Text(
                        "Welcome to",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "AabeHayat!",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ),
                      ),
                      Text(
                        "Ap ki zaroorat, humari zimmedari",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black45,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 50),
                      // Call-to-Action Headings
                      // SizedBox(height: 20),
                      // Row(
                      //   children: [
                      //     Icon(Icons.check,color: Colors.green,),
                      //     SizedBox(width: 5,),
                      //     Expanded(
                      //       child: Text(
                      //         "Your business, now at your fingertips!",
                      //         style: TextStyle(fontSize: 15, color: Colors.black54),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //   Row(
                      //   children: [
                      //     Icon(Icons.check,color: Colors.green,),
                      //     SizedBox(width: 5,),
                      //     Expanded(
                      //       child: Text(
                      //         "No More Hassle – Track All Orders in One Place!",
                      //         style: TextStyle(fontSize: 15, color: Colors.black54),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //   Row(
                      //   children: [
                      //     Icon(Icons.check,color: Colors.green,),
                      //     SizedBox(width: 5,),
                      //     Expanded(
                      //       child: Text(
                      //         "Reach More Customers – Expand Your Shop's Visibility!",
                      //         style: TextStyle(fontSize: 15, color: Colors.black54),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //   Row(
                      //   children: [
                      //     Icon(Icons.check,color: Colors.green,),
                      //     SizedBox(width: 5,),
                      //     Expanded(
                      //       child: Text(
                      //         "Automated Delivery & Payments – Save Time, Earn More!",
                      //         style: TextStyle(fontSize: 15, color: Colors.black54),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  // Spacer(),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => Get.to(() => OnBoardingScreens()),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      OutlinedButton(

                        onPressed: () => Get.to(()=>
                          OnBoardingScreens(),
                          transition: Transition.rightToLeft, // Smooth fade effect
                          duration: Duration(milliseconds: 500),
                        ),

                        style: OutlinedButton.styleFrom(
                          elevation: 0,
                          side: BorderSide(color: kPrimaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18, color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
