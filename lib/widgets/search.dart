import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/text_app.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {

  final double width;
  final IntroController introController;

  const Search({
    required this.width,
    required this.introController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // introController.pressedOnSearch(context);
      },
      child: Container(
        width: width,
        height: AppStyle.getDeviceHeightPercent(6.5, context),
        decoration: BoxDecoration(
          color: AppStyle.greyButton,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          const TextApp(
                text: "Search",
                width: 100,
                height: 30,
                textStyle: CommonTextStyle.textStyleForGreySmallButtonBold
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              child: Container(
                width: AppStyle.getDeviceWidthPercent(11, context),
                decoration: BoxDecoration(
                  color: AppStyle.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: ContainerWithImage(
                      width: 20,
                      height: 20,
                      image: "assets/icons/search.svg",
                      color: Colors.white,
                      option: 0
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}