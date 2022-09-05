import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Intro extends StatelessWidget {
  Intro({Key? key}) : super(key: key);

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: ContainerWithImage(
            width: AppStyle.getDeviceWidthPercent(100, context),
            height: AppStyle.getDeviceHeightPercent(100, context),
            image: "assets/images/BK9.gif",
            option: 1),
        // child: Container(
        //   width: AppStyle.getDeviceWidthPercent(100, context),
        //   height: AppStyle.getDeviceHeightPercent(100, context),
        //   child: Lottie.asset("assets/images/bk9.json",fit: BoxFit.fill),
        // ),
      )
    );
  }


}
