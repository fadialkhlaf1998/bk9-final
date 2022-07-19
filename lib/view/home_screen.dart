import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/home_screen_controller.dart';
import 'package:bk9/view/home.dart';
import 'package:bk9/view/main_page.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            BackgroundImage(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                ContainerWithImage(
                  width: AppStyle.getDeviceWidthPercent(60, context),
                  height: AppStyle.getDeviceHeightPercent(30, context),
                  image: "assets/icons/logo.svg",
                  option: 0,
                ),
                Column(
                  children: [
                    CustomButton(
                        text: "Login / Sign Up",
                        onPressed: () {
                          ///
                        },
                        color: AppStyle.primary,
                        borderRadius: 30,
                        border: Colors.transparent,
                        width: AppStyle.getDeviceWidthPercent(80, context),
                        height: AppStyle.getDeviceHeightPercent(8, context),
                        textStyle: CommonTextStyle.textStyleForOrangeBigButton
                    ),
                    CustomButton(
                        text: "Start Shopping",
                        onPressed: () {
                          Get.to(() => Home());
                        },
                        color: Colors.white,
                        borderRadius: 30,
                        border: AppStyle.primary,
                        width: AppStyle.getDeviceWidthPercent(80, context),
                        height: AppStyle.getDeviceHeightPercent(8, context),
                        textStyle: CommonTextStyle.textStyleForWhiteBigButton
                    ),
                    SizedBox(height: AppStyle.getDeviceHeightPercent(2, context))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
