import 'package:aabehayat_vendor/Utils/DesignConstants.dart';
import 'package:aabehayat_vendor/Widgets/CustomTextField.dart';
import 'package:aabehayat_vendor/Widgets/SpringWidget.dart';
import 'package:aabehayat_vendor/Widgets/customButton.dart';
import 'package:aabehayat_vendor/Views/WaveAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: WaveAnimationScreen(height: 250),
          ),
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
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: Colors.grey.shade400),
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
    );
  }
}
