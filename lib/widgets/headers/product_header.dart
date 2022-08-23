import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/view/wishlist.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';



class ProductHeader extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final VoidCallback onTap;
  final MainPageController mainPageController;
  IntroController introController;

   ProductHeader({
    required this.text,
    required this.textStyle,
    required this.onTap,
    required this.mainPageController,
     required this.introController
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: AppStyle.getDeviceWidthPercent(100, context),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 1,
              offset: Offset(5.0, 5.0,),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: onTap,
                    child: Icon(Icons.arrow_back,size: 23,)
                ),
                SizedBox(width: 20,),
                Container(
                  width: AppStyle.getDeviceWidthPercent(45, context),
                  child: Text(text,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: CommonTextStyle.mediumTextStyle,
                          color: AppStyle.darkGrey,
                          fontWeight: FontWeight.bold,
                      )
                  ),
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    introController.pressedOnSearch(context);
                  },
                  child: Container(
                      height: AppStyle.getDeviceHeightPercent(5, context),
                      width: AppStyle.getDeviceWidthPercent(10.5, context),
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
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.back();
                    Get.back();
                    mainPageController.changeIndexOfBottomBar(3);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SvgPicture.asset("assets/icons/cart.svg",width: 25,height: 25,),
                  )
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => Wishlist());
                    },
                    child: ContainerWithImage(
                        width: 35,
                        height: 70,
                        image: "assets/icons/wishlist.svg",
                        color: AppStyle.grey,
                        option: 0)
                )
              ],
            ),
          ],
        )
    );
  }
}