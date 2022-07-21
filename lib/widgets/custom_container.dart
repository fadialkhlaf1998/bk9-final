import 'package:bk9/const/app-style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomContainer extends StatelessWidget {
  final String? text;
  final VoidCallback onTap;
  final double? radius;
  final double width;
  final double? height;
  final Color color;
  final TextStyle? textStyle;

  const CustomContainer({
    this.text,
    required this.onTap,
    this.radius,
    required this.width,
    this.height,
    required this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color,
              borderRadius: radius == null ? null : BorderRadius.circular(radius!),
          ),
          child: Center(
            child: Text(text == "" ? "" : text!,
            style: textStyle == null ? null : textStyle
            ),
          )
      ),
    );
  }
}