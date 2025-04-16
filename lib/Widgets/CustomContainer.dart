import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: const Color.fromARGB(255, 234, 234, 234),width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
