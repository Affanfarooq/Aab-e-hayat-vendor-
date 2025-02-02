import 'package:flutter/material.dart';

import '../../Const/data_const.dart';

class ScreenPadding extends StatelessWidget {
  final double top;
  final double bottom;
  final double? right;
  final double? left;
  final double horizontalPadding;
  final Widget child;
  const ScreenPadding({
    super.key,
    required this.child,
    this.top = 0.0,
    this.right,
    this.left,
    this.bottom = 0.0,
    this.horizontalPadding = DataConstants.kScreenHorizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: right ?? horizontalPadding,
        left: left ?? horizontalPadding,
        top: top,
        bottom: bottom,
      ),
      child: child,
    );
  }
}