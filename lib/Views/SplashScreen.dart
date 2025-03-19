import 'dart:math' as math;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _heightController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _heightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      reverseDuration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _heightAnimation = Tween<double>(begin: 0, end: 250).animate(
      CurvedAnimation(parent: _heightController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: AnimatedBuilder(
                animation:
                    Listenable.merge([_waveController, _heightAnimation]),
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(250, 250),
                    painter: WavePainter(
                      _waveController.value,
                      _heightAnimation.value,
                    ),
                  );
                },
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image.asset(
                //   "assets/images/icon.png",
                //   width: 50,
                //   height: 50,
                //   fit: BoxFit.contain,
                // ),
                const Text(
                  "Aabehayat",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Aap ki zarurat hamari zimedari",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;
  final double heightShift;

  WavePainter(this.animationValue, this.heightShift);

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

    double waveHeight = 10;
    double baseHeight = size.height - heightShift;

    /// Wave 1 (Fast)
    wavePath1.moveTo(0, baseHeight);
    for (double i = 0; i <= size.width; i++) {
      double y = baseHeight +
          math.sin((i / size.width * 2 * math.pi) +
                  (animationValue * 4 * math.pi)) *
              waveHeight;
      wavePath1.lineTo(i, y);
    }
    wavePath1.lineTo(size.width, size.height);
    wavePath1.lineTo(0, size.height);
    wavePath1.close();

    /// Wave 2 (Slow)
    wavePath2.moveTo(0, baseHeight + 5);
    for (double i = 0; i <= size.width; i++) {
      double y = baseHeight +
          math.sin((i / size.width * 2 * math.pi) -
                  (animationValue * 2 * math.pi)) *
              (waveHeight - 5);
      wavePath2.lineTo(i, y);
    }
    wavePath2.lineTo(size.width, size.height);
    wavePath2.lineTo(0, size.height);
    wavePath2.close();

    // Draw the Waves
    canvas.drawPath(wavePath1, wavePaint1);
    canvas.drawPath(wavePath2, wavePaint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}







