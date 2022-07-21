import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackgroundImage(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/no_intennet.svg",width: 100,height: 100,),
                  Container(
                    width: AppStyle.getDeviceWidthPercent(90, context),
                    height: AppStyle.getDeviceHeightPercent(10, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off,
                          size: 30,
                          color: AppStyle.primary,
                        ),
                        SizedBox(width: 10),
                        Center(
                            child: Text("no internet connection",
                              style: CommonTextStyle.textStyleForDarkGreyBigButton,
                            )
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                      text: "Reload",
                      onPressed: () {
                        API.checkInternet().then((value) {
                          if (value) {
                            Get.back();
                          }
                        });
                      },
                      color: AppStyle.primary,
                      borderRadius: 30,
                      border: AppStyle.primary,
                      width: AppStyle.getDeviceWidthPercent(40, context),
                      height: AppStyle.getDeviceHeightPercent(5, context),
                      textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}
