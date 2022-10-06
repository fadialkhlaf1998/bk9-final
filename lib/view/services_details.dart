import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/home_controller.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/headers/two_items_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesDetails extends StatelessWidget {

  Post? service;
  ServicesDetails(this.service);

  HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 90),
                    Stack(
                        children: [
                          Container(
                            width: AppStyle.getDeviceWidthPercent(100, context),
                            height: AppStyle.getDeviceHeightPercent(30, context),
                            color: service!.color,
                          ),
                          Positioned(
                            child: Hero(
                              tag: "service" + service!.id.toString(),
                              child: Container(
                                  width: AppStyle.getDeviceWidthPercent(100, context),
                                  height: AppStyle.getDeviceHeightPercent(30, context),
                                  child: Image.network(service!.image!,fit: BoxFit.fitWidth,alignment: Alignment.topCenter,)
                              ),
                            ),
                          )
                        ],
                      ),
                    SizedBox(height: 20),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(100, context),
                      color: service!.color,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                        child: Center(
                          child: Text(service!.stringDescription!,
                              style: TextStyle(
                                  fontSize: CommonTextStyle.smallTextStyle,
                                  color: Colors.white,
                                  letterSpacing: 0.5
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                        text: "Book Now",
                        onPressed: () {
                          AppStyle.lunchURL(context, "https://us.revelationpets.com/publicCustomer/3khkvtyvz0/profile");
                        },
                        color: AppStyle.primary,
                        borderRadius: 30,
                        border: AppStyle.primary,
                        width: AppStyle.getDeviceWidthPercent(80, context),
                        height: AppStyle.getDeviceHeightPercent(6.5, context),
                        textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
                    ),
                    SizedBox(height: 10),
                    service!.media==null?Center(): Column(
                      children: service!.media!.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                            width: AppStyle.getDeviceWidthPercent(90, context),
                            // height: AppStyle.getDeviceHeightPercent(30, context),
                            child: Image.network(e.link,fit: BoxFit.contain,alignment: Alignment.topCenter,)
                        ),
                      )).toList(),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: TwoItemsHeader(
                  text: service!.title!,
                  textStyle: CommonTextStyle.textStyleForDarkGreyMediumButton,
                  onTap: () {
                    Get.back();
                  },
                ),
              )
            ],
          ),
        )
    );
  }

}