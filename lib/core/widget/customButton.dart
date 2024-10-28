import 'package:bookia_app/core/utils/color_app.dart';
import 'package:bookia_app/core/utils/textStyle.dart';
import 'package:flutter/material.dart';

class custom_widget_button extends StatelessWidget {
  final Color? color;
  final Color? color_text;
  final double? width;
  final Function() onPressed;
  final String text;

  const custom_widget_button({
    super.key,
    this.color,
    this.width,
    required this.onPressed,
    this.color_text,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? ColorApp.primary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))),
        child: Text(
          text,
          style: smallHint(color: color_text ?? ColorApp.white),
        ),
      ),
    );
  }
}
