import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {

  static const Color primary = Color(0xffff6200);
  static const Color secondery = Color(0xffffffff);
  static const Color grey = Color(0xfff5f5f5);
  static const Color hoverGrey = Color(0xffececec);
  static const Color green = Color(0xff00a550);

  static getDeviceWidthPercent (percent, context){
    return MediaQuery.of(context).size.width * (percent / 100);
  }
  static getDeviceHeightPercent (percent, context){
    return MediaQuery.of(context).size.height * (percent / 100);
  }

}

 abstract class CommonTextStyle{


  static const tinyTextStyle = 12.0;
  static const smallTextStyle = 14.0;
  static const mediumTextStyle = 16;
  static const bigTextStyle = 18.0;
  static const largeTextStyle = 20.0;

  static const textStyleForOrangeBigButton = TextStyle(
    fontSize: bigTextStyle,
    color: Colors.white,
    fontWeight: FontWeight.bold
  );

  static const textStyleForWhiteBigButton = TextStyle(
    fontSize: bigTextStyle,
    color: AppStyle.primary,
    fontWeight: FontWeight.bold
  );


}