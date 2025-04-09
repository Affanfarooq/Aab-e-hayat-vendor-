import 'package:aabehayat_vendor/Const/design_const.dart';
import 'package:flutter/material.dart';

class TextFieldLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? buttonText;
  final VoidCallback? buttonOnTap;
  const TextFieldLabel(
      {super.key,
      required this.label,
      this.isRequired = false,
      this.buttonText,
      this.buttonOnTap});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelMedium;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: label,
                    style: 
                    Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: kTextFieldLabelColor
                    ),
                    
                  ),
                  if (isRequired)
                    TextSpan(
                      text: ' *',
                      style: textStyle!.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                ]),
              ),
            ),
            // if (buttonText != null)
            // HalalTextButton(
            //   label: buttonText!,
            //   onTap: buttonOnTap ?? () {},
            //   isUnderline: true,
            // ),
          ],
        ),
      ],
    );
  }
}
