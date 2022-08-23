import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/account_controller.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVouchers extends StatelessWidget {

  AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _header(context),
                    SizedBox(height: 30),
                    _body(context),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        )
    ));
  }

  _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
      child: Row(
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
            child: Text("My Vouchers",
                style: TextStyle(
                  fontSize: CommonTextStyle.mediumTextStyle,
                  color: AppStyle.darkGrey,
                  fontWeight: FontWeight.bold,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: GestureDetector(
                onTap: () {
                  ///wishlist page
                },
                child: ContainerWithImage(
                    width: 40,
                    height: 70,
                    image: "assets/icons/wishlist.svg",
                    color: Colors.transparent,
                    option: 0)
            ),
          )
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      children: [
        API.discount == 0 ? Text("") :
        Container(
          width: AppStyle.getDeviceWidthPercent(80, context),
          child: Row(
            children: [
              Text("your code: ",
                  style: CommonTextStyle.textStyleForDarkGreySmallButtonNormal
              ),
              Text(API.discountCode,
                  style: CommonTextStyle.textStyleForDarkGreySmallButtonBold
              ),
            ],
          ),
        ),
        SizedBox(height:  API.discount == 0 ? 0 : 10),
        Container(
          width: AppStyle.getDeviceWidthPercent(40, context),
          height: 100,
          decoration: BoxDecoration(
              color:  API.discount == 0.0 ? Colors.red : AppStyle.purple,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: accountController.discountCodeLoading.value ?
            Padding(
              padding: const EdgeInsets.all(20),
              child: CircularProgressIndicator(color: Colors.white,),
            ) :
            Text(
              API.discount == 0.0 ?
              "No Discount Code" :
              API.discount.toStringAsFixed(2) + "% OFF",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: CommonTextStyle.mediumTextStyle
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: AppStyle.getDeviceWidthPercent(80, context),
          child: Row(
            children: [
              Text("Voucher code",
                  style: CommonTextStyle.textStyleForDarkGreySmallButtonNormal
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 55,
          width: AppStyle.getDeviceWidthPercent(85, context),
          child: TextField(
            controller: accountController.voucherCode,
            textAlignVertical: TextAlignVertical.bottom,
            keyboardType: TextInputType.text,
            cursorColor: AppStyle.darkGrey,
            style: TextStyle(color: AppStyle.darkGrey,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: accountController.codeValidate.value ? AppStyle.grey.withOpacity(0.5) : Colors.red),
                  borderRadius: BorderRadius.circular(30)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1,color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(30)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1,color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(30)
              ),
              hintText: 'Code',
              hintStyle: TextStyle(
                  color: AppStyle.grey,
                  fontSize: CommonTextStyle.mediumTextStyle,
                  fontWeight: FontWeight.normal
              ),

            ),
          ),
        ),
        SizedBox(height: 20),
        CustomButton(
            text: "REDEEM",
            onPressed: () {
              accountController.activeDiscount(context);
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: AppStyle.primary,
            width: AppStyle.getDeviceWidthPercent(60, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
      ],
    );
  }


}