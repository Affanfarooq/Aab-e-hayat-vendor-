import 'dart:math' as math;
import 'package:aabehayat_vendor/Services/ShopAuthService.dart';
import 'package:aabehayat_vendor/Views/Dashboard.dart';
import 'package:aabehayat_vendor/Views/WaveAnimation.dart';
import 'package:aabehayat_vendor/Widgets/SpringWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestApprovalScreen extends StatefulWidget {
  @override
  _RequestApprovalScreenState createState() => _RequestApprovalScreenState();
}

class _RequestApprovalScreenState extends State<RequestApprovalScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onRefreshTap() {
    _controller.forward(); 
    checkAndUpdateRequestStatus(); 
  }

  Future<void> checkAndUpdateRequestStatus() async {
    final shopData = await ShopService.getShopData();

    if (shopData != null) {
      bool isApproved = shopData['accountApprove'] ?? false;
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('isRequestApproved', isApproved);
      await prefs.setBool('isRequestPending', !isApproved);

      if (!isApproved) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your request has not been approved yet.'),
            duration: Duration(seconds: 3),
          ),
        );
      }else{
          Get.off(() => Dashboard()); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SizedBox(
                      height: 60,
                    ),
                    Text(
                      "Request Pending",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SvgPicture.asset(
                      'assets/images/requestPending.svg',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Your registration request has been sent to the admin. It will be reviewed within 24 hours. Once approved, your account will be activated and you’ll be notified.",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30), 
                    SpringWidget(
                      onTap: _onRefreshTap,
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _animation.value * 2 * math.pi,
                            child: child,
                          );
                        },
                        child: Icon(
                          Icons.refresh,
                          size: 28,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          WaveAnimationScreen(
            height: 220,
          ),
        ],
      ),
    );
  }
}
