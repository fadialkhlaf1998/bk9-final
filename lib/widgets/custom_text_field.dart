import 'package:bk9/const/app-style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final Widget prefixIcon;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final String text;
  final int maxLength;
  final Color labelColor;
  final bool validate;

  const CustomTextField({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.textEditingController,
    required this.textInputType,
    this.suffixIcon,
    required this.prefixIcon,
    required this.onChanged,
    required this.obscureText,
    required this.text,
    required this.maxLength,
    required this.labelColor,
    required this.validate
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (width / 100),
      height: MediaQuery.of(context).size.height * (height / 100),
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: AppStyle.darkGrey,
        style: TextStyle(color: AppStyle.darkGrey,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
        keyboardType: textInputType,
        obscureText: obscureText,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: text,
          hintStyle: TextStyle(
            color: labelColor,
            fontSize: CommonTextStyle.mediumTextStyle,
            fontWeight: FontWeight.normal
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon == null ? null : suffixIcon,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: validate ? AppStyle.grey.withOpacity(0.5) : Colors.red,
              ),
              borderRadius: BorderRadius.circular(borderRadius)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: validate ?  AppStyle.primary : Colors.red,
              ),
              borderRadius: BorderRadius.circular(borderRadius)
          ),
        ),
      ),
    );
  }
}
