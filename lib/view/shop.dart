import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/shop_controller.dart';
import 'package:bk9/view/categories.dart';
import 'package:bk9/view/new_arrivals.dart';
import 'package:bk9/view/wishlist.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Shop extends StatelessWidget {
  Shop({Key? key}) : super(key: key);

  IntroController introController = Get.find();
  ShopController shopController = Get.put(ShopController());


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
                  SizedBox( height: AppStyle.getDeviceHeightPercent(10, context),),
                  SizedBox(height: 20),
                  _newArrivals(context),
                  _super_category(context),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: _header(context),
            )
          ],
        )
    );
  }

  _header(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(100, context),
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
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Search(width: AppStyle.getDeviceWidthPercent(78, context),introController: introController,),
                GestureDetector(
                    onTap: () {
                      Get.to(() => Wishlist());
                    },
                    child: ContainerWithImage(
                        width: 40,
                        height: 70,
                        image: "assets/icons/wishlist.svg",
                        color: AppStyle.grey,
                        option: 0)
                )
              ],
            ),
          ),
          SizedBox(height: 4,),
        ],
      ),
    );
  }
  _newArrivals(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewArrivals());
      },
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            child: Container(
              width: AppStyle.getDeviceWidthPercent(90, context),
              height: AppStyle.getDeviceHeightPercent(14, context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage("assets/images/background-shop.png",),
                    fit: BoxFit.cover
                  )
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text("New Arrivals",
                    style: CommonTextStyle.textStyleForOrangeMediumButtonBold),
                )
              ),
            ),
          ),
          Container(
            width: AppStyle.getDeviceWidthPercent(90, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Container(
                  margin: EdgeInsets.only(bottom: 25,right: 30),
                  width: AppStyle.getDeviceWidthPercent(30, context),
                  height: AppStyle.getDeviceHeightPercent(15, context),
                  child: SvgPicture.asset("assets/icons/new_arrivals.svg",fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _super_category(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: introController.superCategory.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: GestureDetector(
                onTap:  (){
                  shopController.selectedSuperCategory.value = index;
                  Get.to(() => Categories(introController.superCategory[index].posts!));
                },
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      bottom: 15,
                      child: Container(
                        width: AppStyle.getDeviceWidthPercent(90, context),
                        height: AppStyle.getDeviceHeightPercent(15, context),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage("assets/images/background-shop.png",),
                                fit: BoxFit.cover
                            )
                        ),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Text(introController.superCategory[index].title!,
                                  style: CommonTextStyle.textStyleForOrangeMediumButtonBold),
                            )
                        ),
                      ),
                    ),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(90, context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            width: AppStyle.getDeviceWidthPercent(35, context),
                            height: AppStyle.getDeviceHeightPercent(17, context),
                            child: Image.network(introController.superCategory[index].image!,fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          );
        });
  }


}