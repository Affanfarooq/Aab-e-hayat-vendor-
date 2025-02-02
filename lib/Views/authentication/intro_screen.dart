import 'package:aabehayat_vendor/Services/app_images.dart';
import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:aabehayat_vendor/GenericWidgets/image/education_app_asset_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EducationAppAssetImage(imagePath: AppImages.wellcomeImage),
              Text(
                "Discover Your \nDream Job hHere".tr,
                style: TextStyle(
                  fontSize: 15,
                  color: DesignConstants.kPrimaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "Exploreing all thr existing roles based on your interest and study majar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: DesignConstants.kTextColor,
                  fontWeight: FontWeight.w900,
                ), 
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      color: DesignConstants.kPrimaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                      ),
                    ),
                  ),
        
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Register",

                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
