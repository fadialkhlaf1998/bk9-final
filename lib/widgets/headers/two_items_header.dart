import 'package:bk9/const/app-style.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TwoItemsHeader extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final VoidCallback onTap;

  const TwoItemsHeader({
    required this.text,
    required this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: AppStyle.getDeviceWidthPercent(100, context),
        height: AppStyle.getDeviceHeightPercent(8, context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 1,
              offset: Offset(5.0, 5.0,),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: onTap,
                    child: Icon(Icons.arrow_back,size: 23,)
                ),
                SizedBox(width: 20),
                Text(text, style: textStyle),
              ],
            ),
          ],
        )
    );
  }
}