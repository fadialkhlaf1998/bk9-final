import 'package:bk9/const/app-style.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final Color border;
  final double width;
  final double height;
  final TextStyle textStyle;

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.color,
    required this.borderRadius,
    required this.border,
    required this.width,
    required this.height,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Center(
        child: Container(
          height: this.height,
          width: this.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color,
              onPrimary: color,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: this.border),
                borderRadius: BorderRadius.circular(
                  this.borderRadius,
                ),

              ),
            ),
            child: FittedBox(
              child: Text(
                text,
                style: textStyle  // this.textStyle,
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}