import 'package:flutter/material.dart';

class AppStyle {

  static const Color primary = Color(0xffff6200);
  static const Color greyButton = Color(0xfff6f6f6);
  static const Color darkGrey = Color(0xff383838);
  static const Color grey = Color(0xff77787a);
  static const Color hoverGrey = Color(0xffececec);


  static getDeviceWidthPercent (percent, context){
    return MediaQuery.of(context).size.width * (percent / 100);
  }
  static getDeviceHeightPercent (percent, context){
    return MediaQuery.of(context).size.height * (percent / 100);
  }

  static Color hexToColor(String? code) {
    try{
      if(code == null){
        return Colors.blue;
      }else{
        return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
      }
    }catch(e){
      return Colors.blue;
    }
  }

}

 abstract class CommonTextStyle{

  static const tinyTextStyle = 12.0;
  static const smallTextStyle = 14.0;
  static const mediumTextStyle = 16;
  static const bigTextStyle = 18.0;
  static const largeTextStyle = 20.0;
  static const xlargeTextStyle = 22.0;

  static const textStyleForBottomBar = TextStyle(
    fontSize: 10,
    color: AppStyle.grey,
  );

  static const textStyleForSelectBottomBar = TextStyle(
      fontSize: 10,
      color: AppStyle.primary,
      fontWeight: FontWeight.bold
  );

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

  static const textStyleForDarkGreyBigButton = TextStyle(
      fontSize: bigTextStyle,
      color: AppStyle.darkGrey,
      fontWeight: FontWeight.bold
  );

  static const textStyleForDarkGreyXLargeButton = TextStyle(
      fontSize: xlargeTextStyle,
      color: AppStyle.darkGrey,
      fontWeight: FontWeight.bold
  );

  static const textStyleForGreyBigButton = TextStyle(
      fontSize: bigTextStyle,
      color: AppStyle.grey,
      fontWeight: FontWeight.normal
  );

  static const textStyleForGreyBigButtonBold = TextStyle(
      fontSize: bigTextStyle,
      color: AppStyle.grey,
      fontWeight: FontWeight.bold
  );


}