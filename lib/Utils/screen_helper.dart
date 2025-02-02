import 'package:flutter/material.dart';


class ScreenHelper {
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
}