import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Intro extends StatelessWidget {
  Intro({Key? key}) : super(key: key);

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerWithImage(
          width: AppStyle.getDeviceWidthPercent(100, context),
          height: AppStyle.getDeviceHeightPercent(100, context),
          image: "assets/images/Loading.png",
          option: 1)
    );
  }
}
