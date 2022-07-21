import 'package:flutter/material.dart';

class TextForDescIntroScreen extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final TextStyle textStyle;

  const TextForDescIntroScreen({
    required this.text,
    required this.width,
    required this.height,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Text(text,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}