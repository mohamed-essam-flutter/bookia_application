import 'package:bookia_app/core/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextStyle headTitle(
    {double? fontSize,
    FontWeight? fontWeight = FontWeight.normal,
    Color? color}) {
  return TextStyle(
      fontSize: fontSize ?? 30,
      color: color ?? ColorApp.black,
      fontWeight: fontWeight,
      fontFamily: 'DMSerifDisplay');
}

TextStyle smallHint(
    {double? fontSize,
    FontWeight? fontWeight = FontWeight.normal,
    Color? color}) {
  return TextStyle(
      fontSize: fontSize ?? 15,
      color: color ?? ColorApp.gray,
      fontWeight: fontWeight,
      fontFamily: 'DMSerifDisplay');
}

TextStyle titleAppbar(
    {double? fontSize,
    FontWeight? fontWeight = FontWeight.normal,
    Color? color}) {
  return TextStyle(
      fontSize: fontSize ?? 24,
      color: color ?? ColorApp.gray,
      fontWeight: fontWeight,
      fontFamily: 'DMSerifDisplay');
}
