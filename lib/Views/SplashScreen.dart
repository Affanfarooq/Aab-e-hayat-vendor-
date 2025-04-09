import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'OnboardingScreens.dart';

class SplashScreenAnimation extends StatefulWidget {
  @override
  _SplashScreenAnimationState createState() => _SplashScreenAnimationState();
}

class _SplashScreenAnimationState extends State<SplashScreenAnimation>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          WaveAnimationForSplashScreen(
              // onAnimationComplete: () {
              //   Get.to(() => OnBoardingScreen(), transition: Transition.rightToLeftWithFade);
              // },
              ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/splash.svg',
                  height: 120,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10,),
                Text(
                  "AABEHAYAT",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Aapki zarrorat hamari zimydari",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveAnimationForSplashScreen extends StatefulWidget {
  final double? height;
  final VoidCallback? onAnimationComplete;

  const WaveAnimationForSplashScreen(
      {Key? key, this.height, this.onAnimationComplete})
      : super(key: key);

  @override
  _WaveAnimationForSplashScreenState createState() =>
      _WaveAnimationForSplashScreenState();
}

class _WaveAnimationForSplashScreenState
    extends State<WaveAnimationForSplashScreen> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _heightController;
  late AnimationController _fillController;
  late Animation<double> _heightAnimation;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 2),
    )..repeat();

    // Increase the duration to slow down the wave's rise
    _heightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Slow down to 3 seconds
      reverseDuration: const Duration(seconds: 3), // Slow reverse as well
    )..repeat(reverse: true);

    _fillController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Gradual height increase to cover the screen more slowly
    _heightAnimation = Tween<double>(
      begin: 0,
      end: 1, // Transitioning from 0 to 1 to cover the entire screen height
    ).animate(
      CurvedAnimation(parent: _heightController, curve: Curves.easeInOut),
    );

    _fillAnimation = Tween<double>(begin: 0.9, end: 0.1).animate(
      CurvedAnimation(parent: _fillController, curve: Curves.easeInOut),
    );

    _fillController.forward();

    _fillController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _heightController.dispose();
    _fillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.height != null) {
      return AnimatedBuilder(
        animation: Listenable.merge(
            [_waveController, _heightAnimation, _fillAnimation]),
        builder: (context, child) {
          return CustomPaint(
            painter: WavePainter(
              _waveController.value,
              _heightAnimation.value *
                  MediaQuery.of(context).size.height, // Full screen height
              widget.height == null ? _fillAnimation.value : 0.1,
            ),
            size: Size(MediaQuery.of(context).size.width, widget.height!),
          );
        },
      );
    }

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: AnimatedBuilder(
        animation: Listenable.merge(
            [_waveController, _heightAnimation, _fillAnimation]),
        builder: (context, child) {
          return CustomPaint(
            painter: WavePainter(
              _waveController.value,
              _heightAnimation.value *
                  MediaQuery.of(context).size.height, // Full screen height
              _fillAnimation.value,
            ),
            child: Container(),
          );
        },
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final double heightShift;
  final double baseHeightFactor;

  WavePainter(this.animationValue, this.heightShift, this.baseHeightFactor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint1 = Paint()
      ..color = const Color(0xffBEECFF)
      ..style = PaintingStyle.fill;

    Paint wavePaint2 = Paint()
      ..color = const Color(0xff9BE1FF)
      ..style = PaintingStyle.fill;

    Path wavePath1 = Path();
    Path wavePath2 = Path();

    double waveHeight = 8;
    double speedFactor1 = animationValue * 9 * math.pi * 10;
    double speedFactor2 = animationValue * 2 * math.pi * 10;

    // Base Height Adjusted for Smooth Transition
    double baseHeight = size.height * baseHeightFactor - heightShift;

    // Wave 1
    wavePath1.moveTo(0, baseHeight);
    for (double i = 0; i <= size.width; i++) {
      double y = baseHeight +
          math.sin((i / size.width * 2 * math.pi) + speedFactor1) * waveHeight +
          math.sin(animationValue * 2 * math.pi * 2) * 5;
      wavePath1.lineTo(i, y);
    }
    wavePath1.lineTo(size.width, size.height);
    wavePath1.lineTo(0, size.height);
    wavePath1.close();

    // Wave 2
    wavePath2.moveTo(0, baseHeight + 7);
    for (double i = 0; i <= size.width; i++) {
      double y = baseHeight +
          math.sin((i / size.width * 2 * math.pi) - speedFactor2) *
              (waveHeight - 0.2) +
          math.cos(animationValue * 2 * math.pi * 2) * 5;
      wavePath2.lineTo(i, y);
    }
    wavePath2.lineTo(size.width, size.height);
    wavePath2.lineTo(0, size.height);
    wavePath2.close();

    // Draw Waves
    canvas.drawPath(wavePath1, wavePaint1);
    canvas.drawPath(wavePath2, wavePaint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
