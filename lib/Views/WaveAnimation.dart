
import 'dart:developer';
import 'dart:math' as math;
import 'package:aabehayat_vendor/Controllers/ShopAuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaveAnimationScreen extends StatefulWidget {
  final double? height;
  
  const WaveAnimationScreen({Key? key, this.height}) : super(key: key);
  
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
  late ShopAuthController controller;

  @override
  void initState() {
    super.initState();
    try {
      controller = Get.find<ShopAuthController>();
    } catch (e) {
      controller = Get.put(ShopAuthController());
    }
    
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
      duration: const Duration(seconds: 2),
    );

    // Height animation for wave motion
    _heightAnimation = Tween<double>(begin: 0, end: 35).animate(
      CurvedAnimation(parent: _heightController, curve: Curves.easeInOut),
    );

    // Initial Base Height Animation
    _baseHeightAnimation = Tween<double>(
      begin: 0.5,
      end: 0.5,
    ).animate(_baseHeightController);

  
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
    // For custom height, return a Container with fixed height
    if (widget.height != null) {
      return AnimatedBuilder(
        animation: Listenable.merge(
            [_waveController, _heightAnimation, _baseHeightAnimation]),
        builder: (context, child) {
          return CustomPaint(
            painter: WavePainter(
              _waveController.value,
              _heightAnimation.value,
              widget.height == null ? _baseHeightAnimation.value : 0.1,
            ),
            size: Size(MediaQuery.of(context).size.width, widget.height!),
          );
        },
      );
    }
    
    // Original implementation for full-screen wave
    return Column(
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



