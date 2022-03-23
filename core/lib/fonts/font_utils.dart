import 'package:flutter/material.dart';

const String fontFamily = 'maison';

class FontUtils {
  static TextStyle getAppFont(
      {required double fontSize,
      required Color textColor,
      required FontWeight fontWeight}) {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight);
  }
}
