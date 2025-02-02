import 'dart:developer';

import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class CustomSpringButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomSpringButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CustomSpringButtonState createState() => _CustomSpringButtonState();
}

class _CustomSpringButtonState extends State<CustomSpringButton> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    log("PRESSED");
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          scale = 0.95; // Slight shrink effect
        });
      },
      onTapUp: (_) {
        Future.delayed(Duration(milliseconds: 0), () {
          setState(() {
            scale = 1.0; // Smooth return to normal
          });
          widget.onPressed(); // Call the button action
        });
      },
      onTapCancel: () {
        setState(() {
          scale = 1.0; // Reset scale if tap is canceled
        });
      },
      child: AnimatedScale(
        scale: scale, // Animated scaling effect
        duration: Duration(milliseconds: 300), // Smooth animation duration
        curve: Curves.easeOutBack, // Easing effect for smooth transition
        child: Container(
          width: 200, // Full width button
          padding: EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Colors.blue, // Button color
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}