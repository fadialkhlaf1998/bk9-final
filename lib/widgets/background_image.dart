import 'package:bk9/const/app-style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BackgroundImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppStyle.getDeviceWidthPercent(100, context),
        height: AppStyle.getDeviceHeightPercent(100, context),
        child: Image.asset("assets/images/Background.png", fit: BoxFit.cover,)
    );
  }
}