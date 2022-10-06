import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/controller/wishlist_controller.dart';
import 'package:bk9/view/login.dart';
import 'package:bk9/view/signup.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Wishlist extends StatelessWidget {

  MainPageController mainPageController = Get.find();
  WishListController wishListController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackgroundImage(),
              wishListController.fake.value ? Center() : Center(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 90),
                    API.customer_id == -1 ?
                    _notLogin(context) : wishListController.wishlist.isEmpty ?
                    _emptyWishlist(context) :
                    _notEmptyWishlist(context),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: _header(context)
              )
            ],
          ),
        )
    ));
  }
  _header(BuildContext context) {
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
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back,size: 23,)
              ),
              SizedBox(width: 25),
              Container(
                width: AppStyle.getDeviceWidthPercent(45, context),
                child: Text("My Wishlist",
                    style: TextStyle(
                      fontSize: CommonTextStyle.mediumTextStyle,
                      color: AppStyle.darkGrey,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: ContainerWithImage(
                width: 40,
                height: 70,
                image: "assets/icons/wishlist.svg",
                color: Colors.grey,
                option: 0)
          )
        ],
      ),
    );
  }
  _notLogin(BuildContext context) {
    return Container(
        width: AppStyle.getDeviceWidthPercent(90, context),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(1,3),
              ),
            ]
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create an account and save your wishlist!",
                  style: CommonTextStyle.textStyleForGreyMediumButtonBold,
                ),
                SizedBox(height: 15,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    Container(
                      width: 7,
                      height: 20,
                      decoration: BoxDecoration(
                          color: AppStyle.grey,
                          shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(75, context),
                      child: Text("Save, organize and get feedback on the products you're interested in.",
                        style: CommonTextStyle.textStyleForGreyMediumButton,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    Container(
                      width: 7,
                      height: 20,
                      decoration: BoxDecoration(
                          color: AppStyle.grey,
                          shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(75, context),
                      child: Text("Share your wishlist with your family and make shopping decisions together.",
                        style: CommonTextStyle.textStyleForGreyMediumButton,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    Container(
                      width: 7,
                      height: 20,
                      decoration: BoxDecoration(
                          color: AppStyle.grey,
                          shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(75, context),
                      child: Text("Use wishlist to discover and discuss giftd. Never buy the wrong gift again.",
                        style: CommonTextStyle.textStyleForGreyMediumButton,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                CustomButton(
                    text: "Login",
                    onPressed: () {
                      Get.to(() => Login());
                    },
                    color: AppStyle.primary,
                    borderRadius: 30,
                    border: Colors.transparent,
                    width: AppStyle.getDeviceWidthPercent(80, context),
                    height: AppStyle.getDeviceHeightPercent(6.5, context),
                    textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
                ),
                SizedBox(height: 10,),
                CustomButton(
                    text: "Create An Account",
                    onPressed: () {
                      Get.to(() => SignUp());
                    },
                    color: AppStyle.primary,
                    borderRadius: 30,
                    border: Colors.transparent,
                    width: AppStyle.getDeviceWidthPercent(80, context),
                    height: AppStyle.getDeviceHeightPercent(6.5, context),
                    textStyle:  CommonTextStyle.textStyleForOrangeMediumButtonBold
                ),
              ],
            )
        )
    );
  }
  _emptyWishlist(BuildContext context) {
    return Column(
      children: [
        TextApp(text: "Your Wishlist Is Empty",
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(8, context),
            textStyle: CommonTextStyle.textStyleForDarkGreySmallButtonBold
        ),
        SvgPicture.asset("assets/icons/cart.svg",width: 50,height: 50,color: Colors.grey,),
        SizedBox(height: 10),
        CustomButton(
            text: "Continue Shopping",
            onPressed: () {
              Get.back();
              mainPageController.changeIndexOfBottomBar(1);
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
      ],
    );
  }
  _notEmptyWishlist(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(90, context),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: wishListController.wishlist.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(wishListController.wishlist[index].image!),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                    onTap: () {
                                      wishListController.deleteFromWishlist(wishListController.wishlist[index]);
                                    },
                                    child: Icon(Icons.close,size: 23,color: Colors.grey,)),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(wishListController.wishlist[index].title!,
                                maxLines: 2,
                                style: TextStyle(
                                    color: AppStyle.darkGrey,
                                    fontSize: CommonTextStyle.smallTextStyle,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("AED" + " " + wishListController.wishlist[index].price.toString(),
                                    style: TextStyle(
                                      color: AppStyle.darkGrey,
                                      fontSize: CommonTextStyle.smallTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }


}