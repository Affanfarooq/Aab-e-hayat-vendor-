// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class WaveAnimationScreen extends StatefulWidget {
//   final RxInt currentStep;
//   WaveAnimationScreen({required this.currentStep});
//   @override
//   _WaveAnimationScreenState createState() => _WaveAnimationScreenState();
// }

// class _WaveAnimationScreenState extends State<WaveAnimationScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _waveController;
//   late AnimationController _heightController;
//   late Animation<double> _heightAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Wave Animation Controller
//     _waveController = AnimationController(
//       vsync: this,
//       duration: const Duration(minutes: 2),
//     )..repeat();

//     // Height Animation Controller
//     _heightController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//       reverseDuration: const Duration(seconds: 3),
//     )..repeat(reverse: true);

//     // Corrected Tween
//     _heightAnimation = Tween<double>(begin: 0, end: 45).animate(
//       CurvedAnimation(parent: _heightController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _waveController.dispose();
//     _heightController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: AnimatedBuilder(
//         animation: Listenable.merge([_waveController, _heightAnimation]),
//         builder: (context, child) {
//           return CustomPaint(
//             painter: WavePainter(_waveController.value, _heightAnimation.value),
//             child: Container(),
//           );
//         },
//       ),
//     );
//   }
// }

// class WavePainter extends CustomPainter {
//   final double animationValue;
//   final double heightShift;

//   WavePainter(this.animationValue, this.heightShift);

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint wavePaint1 = Paint()
//       ..color = const Color(0xffBEECFF)
//       ..style = PaintingStyle.fill;

//     Paint wavePaint2 = Paint()
//       ..color = const Color(0xff9BE1FF)
//       ..style = PaintingStyle.fill;

//     Path wavePath1 = Path();
//     Path wavePath2 = Path();

//     double waveHeight = 10;
//     double speedFactor1 = animationValue * 9 * math.pi * 10;
//     double speedFactor2 = animationValue * 2 * math.pi * 10;

//     // Base Height Adjusted for Up-Down Motion
//     double baseHeight = size.height * 0.8 - heightShift;

//     // Wave 1
//     wavePath1.moveTo(0, baseHeight);
//     for (double i = 0; i <= size.width; i++) {
//       double y = baseHeight +
//           math.sin((i / size.width * 2 * math.pi) + speedFactor1) * waveHeight +
//           math.sin(animationValue * 2 * math.pi * 2) * 5;
//       wavePath1.lineTo(i, y);
//     }
//     wavePath1.lineTo(size.width, size.height);
//     wavePath1.lineTo(0, size.height);
//     wavePath1.close();

//     // Wave 2
//     wavePath2.moveTo(0, baseHeight + 7);
//     for (double i = 0; i <= size.width; i++) {
//       double y = baseHeight +
//           math.sin((i / size.width * 2 * math.pi) - speedFactor2) *
//               (waveHeight - 0.2) +
//           math.cos(animationValue * 2 * math.pi * 2) * 5;
//       wavePath2.lineTo(i, y);
//     }
//     wavePath2.lineTo(size.width, size.height);
//     wavePath2.lineTo(0, size.height);
//     wavePath2.close();

//     // Draw Waves
//     canvas.drawPath(wavePath1, wavePaint1);
//     canvas.drawPath(wavePath2, wavePaint2);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }


import 'dart:developer';
import 'dart:math' as math;
import 'package:aabehayat_vendor/Views/OnboardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaveAnimationScreen extends StatefulWidget {
  @override
  _WaveAnimationScreenState createState() => _WaveAnimationScreenState();
}

class _WaveAnimationScreenState extends State<WaveAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _heightController;
  late AnimationController _baseHeightController;
  late Animation<double> _heightAnimation;
  late Animation<double> _baseHeightAnimation;
  final controller = Get.find<OnboardingsController>();

  @override
  void initState() {
    super.initState();

    // Wave Animation Controller
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 2),
    )..repeat();

    // Height Animation Controller
    _heightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Smooth Base Height Transition Controller
    _baseHeightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Smooth transition duration
    );

    // Height animation for wave motion
    _heightAnimation = Tween<double>(begin: 0, end: 45).animate(
      CurvedAnimation(parent: _heightController, curve: Curves.easeInOut),
    );

    // Initial Base Height Animation (Will update when `currentStep` changes)
    _baseHeightAnimation = Tween<double>(
      begin: 0.55, // Default first index height
      end: 0.55,
    ).animate(_baseHeightController);

    // Listen to step changes and update base height animation
    ever(controller.currentStep, (step) {
      double newBaseHeight = (step == 0) ? 0.55 : 0.8;

      _baseHeightAnimation = Tween<double>(
        begin: _baseHeightAnimation.value, // Current height
        end: newBaseHeight, // New height
      ).animate(CurvedAnimation(
          parent: _baseHeightController, curve: Curves.easeInOut));

      _baseHeightController.forward(from: 0); // Restart animation
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    _heightController.dispose();
    _baseHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Obx(() {
            log('STEP : ${controller.currentStep.value}');
            return SizedBox();
          }),
          Expanded(
            child: AnimatedBuilder(
              animation: Listenable.merge(
                  [_waveController, _heightAnimation, _baseHeightAnimation]),
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(
                    _waveController.value,
                    _heightAnimation.value,
                    _baseHeightAnimation.value,
                  ),
                  child: Container(),
                );
              },
            ),
          ),
        ],
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