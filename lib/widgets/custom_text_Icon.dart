import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomTextIcon extends StatelessWidget {

  final Callback onTap;
  final double width;
  final Color color;
  final BorderRadius borderRadius;
  final double width2;
  final String text;
  final TextStyle textStyle;
  final IconData icon;
  final Color iconColor;
  final Widget animatedChild;

  const CustomTextIcon({
    required this.onTap,
    required this.width,
    required this.color,
    required this.borderRadius,
    required this.width2,
    required this.text,
    required this.textStyle,
    required this.icon,
    required this.iconColor,
    required this.animatedChild
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            decoration: BoxDecoration(
                color: color,
                borderRadius: borderRadius
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width2,
                    child: Text(text,
                      style: textStyle
                    ),
                  ),
                  Icon(icon, color: iconColor)
                ],
              ),
            ),
          ),
        ),
       animatedChild
      ],
    );
  }
}