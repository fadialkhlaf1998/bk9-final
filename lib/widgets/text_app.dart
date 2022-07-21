import 'package:flutter/material.dart';

class TextApp extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final TextStyle textStyle;

  const TextApp({
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
          style: textStyle,
        ),
      ),
    );
  }
}