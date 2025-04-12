
import 'package:aabehayat_vendor/Utils/DesignConstants.dart';
import 'package:aabehayat_vendor/Widgets/SpringWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final IconData? icon;
  final Color? color;
  final int? height;
  final double? radius;
  final Color? textColor;
  final double? textSize;
  final FontWeight fontWeight;

   CustomButton({
    Key? key,
    required this.title,
    this.onTap,
    this.icon,
    this.color, 
    this.height = 55,
    this.radius = 20,
    this.textColor,
    this.textSize = 15,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpringWidget(
      intensity: 0.96,
      onTap: onTap,
      child: Container(
        height: height!.toDouble(),
        decoration: BoxDecoration(
          color: color ?? kPrimaryColor,
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon!=null? Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(icon, color: Colors.white),
            ):SizedBox.shrink(),
            
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: textSize, fontWeight: fontWeight, color: textColor,),
            ),
          ],
        ),
      ),
    );
  }
}
