import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AppStyle {

  static const Color primary = Color(0xffff6200);
  static const Color greyButton = Color(0xfff6f6f6);
  static const Color darkGrey = Color(0xff383838);
  static const Color grey = Color(0xff77787a);
  static const Color productGrey = Color(0xff777777);
  static const Color lightGrey = Color(0xffeeeeee);
  static const Color lightOrange = Color(0xffffe9d0);
  static const Color red = Color(0xffff0619);
  static const Color blue = Color(0xff1d70b7);
  static const Color purple = Color(0xff662482);
  static const Color green = Color(0xff03a550);


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
  static successMsg(BuildContext context, String msg) {
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: msg,
        backgroundColor: AppStyle.primary,
      ),
    );
  }
  static errorMsg(BuildContext context, String err) {
    return showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: err,
      ),
    );
  }
  ///url
  static void lunchURL(BuildContext context,String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      errorMsg(context, "something_wrong");
    } else {
      await launchUrl(Uri.parse(url));
    }
  }
}

 abstract class CommonTextStyle{

  static const tinyTextStyle = 12.0;
  static const smallTextStyle = 14.0;
  static const mediumTextStyle = 16.0;
  static const bigTextStyle = 18.0;
  static const largeTextStyle = 20.0;
  static const xlargeTextStyle = 22.0;
  static const xxlargeTextStyle = 26.0;

  ///bottom bar
  static const textStyleForBottomBar = TextStyle(
    fontSize: 10,
    color: AppStyle.grey,
  );
  static const textStyleForSelectBottomBar = TextStyle(
      fontSize: 10,
      color: AppStyle.primary,
      fontWeight: FontWeight.bold
  );

  ///orange
  static const textStyleForOrangeBigButton = TextStyle(
    fontSize: bigTextStyle,
    color: Colors.white,
    fontWeight: FontWeight.bold
  );
  static const textStyleForOrangeMediumButton = TextStyle(
      fontSize: mediumTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.normal
  );

  static const textStyleForOrangeMediumButtonBold = TextStyle(
      fontSize: mediumTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.bold
  );

  ///white
  static const textStyleForWhiteBigButton = TextStyle(
    fontSize: bigTextStyle,
    color: AppStyle.primary,
    fontWeight: FontWeight.bold
  );
  static const textStyleForWhiteMediumButton = TextStyle(
      fontSize: mediumTextStyle,
      color: AppStyle.primary,
      fontWeight: FontWeight.bold
  );
  static const textStyleForWhiteSmallButton = TextStyle(
      fontSize: smallTextStyle,
      color: AppStyle.primary,
      fontWeight: FontWeight.bold
  );
  static const textStyleForWhiteSmallButtonNormal = TextStyle(
      fontSize: smallTextStyle,
      color: AppStyle.primary,
      fontWeight: FontWeight.normal
  );
  static const textStyleForWhiteXLargeButton = TextStyle(
      fontSize: xlargeTextStyle,
      color: Colors.white,
      fontWeight: FontWeight.bold
  );

  ///dark Grey
  static const textStyleForDarkGreySmallButtonBold = TextStyle(
      fontSize: smallTextStyle,
      color: AppStyle.darkGrey,
      fontWeight: FontWeight.bold
  );

  static const textStyleForDarkGreySmallButtonNormal = TextStyle(
      fontSize: smallTextStyle,
      color: AppStyle.darkGrey,
  );

  static const textStyleForDarkGreyMediumButton = TextStyle(
      fontSize: mediumTextStyle,
      color: AppStyle.darkGrey,
      fontWeight: FontWeight.bold
  );
  static const textStyleForDarkGreyBigButton = TextStyle(
      fontSize: bigTextStyle,
      color: AppStyle.darkGrey,
      fontWeight: FontWeight.bold
  );
  static const textStyleForDarkGreyLargeButton = TextStyle(
      fontSize: largeTextStyle,
      color: AppStyle.darkGrey,
      fontWeight: FontWeight.bold
  );
  static const textStyleForDarkGreyXLargeButton = TextStyle(
      fontSize: xlargeTextStyle,
      color: AppStyle.darkGrey,
      fontWeight: FontWeight.bold
  );

  ///grey
  static const textStyleForGreyBigButton = TextStyle(
      fontSize: bigTextStyle,
      color: AppStyle.grey,
      fontWeight: FontWeight.normal
  );
  static const textStyleForGreyMediumButton = TextStyle(
      fontSize: mediumTextStyle,
      color: AppStyle.grey,
      fontWeight: FontWeight.normal
  );
  static const textStyleForGreyMediumButtonBold = TextStyle(
      fontSize: mediumTextStyle,
      color: AppStyle.grey,
      fontWeight: FontWeight.bold
  );
  static const textStyleForGreyBigButtonBold = TextStyle(
      fontSize: bigTextStyle,
      color: AppStyle.grey,
      fontWeight: FontWeight.bold
  );

  static const textStyleForGreySmallButton = TextStyle(
      fontSize: smallTextStyle,
      color: AppStyle.grey,
      fontWeight: FontWeight.normal
  );

  static const textStyleForGreyTinyButton = TextStyle(
      fontSize: tinyTextStyle,
      color: AppStyle.grey,
      fontWeight: FontWeight.normal
  );

  static const textStyleForGreySmallButtonBold = TextStyle(
      fontSize: smallTextStyle,
      color: AppStyle.grey,
      fontWeight: FontWeight.bold
  );


}