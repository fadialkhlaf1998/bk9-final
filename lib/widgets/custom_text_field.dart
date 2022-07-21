import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final String labelText;
  final int maxLength;
  final Color borderColor;
  final Color focusedBorderColor;

  const CustomTextField({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.textEditingController,
    required this.textInputType,
    required this.suffixIcon,
    required this.prefixIcon,
    required this.onChanged,
    required this.obscureText,
    required this.labelText,
    required this.maxLength,
    required this.borderColor,
    required this.focusedBorderColor
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (width / 100),
      height: MediaQuery.of(context).size.height * (height / 100),
      child: TextField(
        keyboardType: textInputType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.white,
          hoverColor: Colors.white,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedBorderColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius)
          ),
        ),
      ),
    );
  }
}
