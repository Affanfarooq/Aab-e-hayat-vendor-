import 'package:aabehayat_vendor/Utils/DesignConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildInputField(
  TextEditingController controller,
  String label, {
  TextInputType keyboardType = TextInputType.text,
  String? icon,
}) {
  return AppTextField(
    controller: controller,
    hintText: label,
    iconPath: "assets/images/${icon}",
  );
}


class AppTextField extends StatelessWidget {
  final String hintText;
  final String? iconPath;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const AppTextField({
    Key? key,
    required this.hintText,
    required this.iconPath, 
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 15),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
        ),
        prefixIcon: iconPath != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13), 
                child: SizedBox(
                  width: 14, 
                  height: 14, 
                  child: SvgPicture.asset(
                    iconPath!,
                    color: const Color.fromARGB(255, 202, 201, 201),
                    fit: BoxFit.contain, 
                  ),
                ),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
    );
  }
}
