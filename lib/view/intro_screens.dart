import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_screen_controller.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/text_app.dart';
import 'package:bk9/widgets/text_for_desc_intro_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  IntroScreenController introScreenController = Get.put(IntroScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundImage(),
            Column(
              children: [
                Container(
                    width: AppStyle.getDeviceWidthPercent(100, context),
                    height: AppStyle.getDeviceHeightPercent(80, context),
                    child: ScrollablePositionedList.builder(
                      itemScrollController: introScreenController.itemScrollController,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: introScreenController.screens.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 60),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                              child: SvgPicture.asset(introScreenController.screens[index]["image"],height: AppStyle.getDeviceWidthPercent(50, context),)
                            ),
                            SizedBox(height: 60,),
                            TextApp(text: introScreenController.screens[index]["title"],
                                width: AppStyle.getDeviceWidthPercent(100, context),
                                height: AppStyle.getDeviceWidthPercent(8, context),
                                textStyle: CommonTextStyle.textStyleForDarkGreyXLargeButton
                            ),
                            TextForDescIntroScreen(text: introScreenController.screens[index]["description"],
                                width: AppStyle.getDeviceWidthPercent(70, context),
                                height: AppStyle.getDeviceWidthPercent(20, context),
                                textStyle: CommonTextStyle.textStyleForGreySmallButton
                            ),
                            SizedBox(height: 10,),
                            Obx(() => DotsIndicator(
                              dotsCount: introScreenController.screens.length,
                              position: double.parse(introScreenController.nextValue.value.toString()),
                              decorator: DotsDecorator(
                                activeColor: AppStyle.darkGrey,
                                color: AppStyle.grey.withOpacity(0.5),
                              ),
                            ),),
                          ],
                        );
                      },
                    )
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: backAndNextButtom(context)
            ),
          ],
        ),
      ),
    );
  }
  backAndNextButtom(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(100, context),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  text: "Back",
                  onPressed: () {
                    introScreenController.goToPreviousPage();
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(35, context),
                  height: AppStyle.getDeviceHeightPercent(6, context),
                  textStyle: CommonTextStyle.textStyleForDarkGreyMediumButton
              ),
              CustomButton(
                  text: "Next",
                  onPressed: () {
                    introScreenController.goToNextPage();
                  },
                  color: AppStyle.primary,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(35, context),
                  height: AppStyle.getDeviceHeightPercent(6, context),
                  textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
              ),
            ],
          ),
          SizedBox(height: 30)
        ],
      )
    );
  }
}
