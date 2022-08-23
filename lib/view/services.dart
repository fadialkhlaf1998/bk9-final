import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/view/home.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/custom_gridView_services.dart';
import 'package:bk9/widgets/headers/three_items_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Services extends StatelessWidget {
  Services({Key? key}) : super(key: key);

  MainPageController mainPageController = Get.find();
  IntroController introController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ThreeItemsHeader(
                      onTap: () {
                        mainPageController.changeIndexOfBottomBar(0);
                      },
                      introController: introController,
                      text: "Services",
                      textStyle: CommonTextStyle.textStyleForGreyMediumButtonBold
                  ),
                  SizedBox(height: 10,),
                  _servicesList(context,introController),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: ThreeItemsHeader(
                  onTap: () {
                    mainPageController.changeIndexOfBottomBar(0);
                  },
                  introController: introController,
                  text: "Services",
                  textStyle: CommonTextStyle.textStyleForGreyMediumButtonBold
              ),
            )
          ],
        )
    );
  }

  _servicesList(BuildContext context,IntroController introController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CustomGridViewServices(
        count: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        containerPadding: 5,
        padding: 8,
        introController: introController,
      ),
    );
  }


}