import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/verification_code_controller.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VerificationCode extends StatelessWidget {

  VerificationCodeController verificationCodeController = Get.put(VerificationCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: MediaQuery.of(context).viewPadding.top - 10),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          width: AppStyle.getDeviceWidthPercent(90, context),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back,size: 23,color: AppStyle.darkGrey,),
                            ],
                          )
                      ),
                    ),
                    ContainerWithImage(
                      width: AppStyle.getDeviceWidthPercent(50, context),
                      height: AppStyle.getDeviceHeightPercent(30, context),
                      image: "assets/icons/logo.svg",
                      option: 0,
                    ),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(80, context),
                      height: AppStyle.getDeviceHeightPercent(5.5, context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Verification Code",
                            style: CommonTextStyle.textStyleForDarkGreyBigButton,
                          ),
                        ],
                      ),
                    ),
                    normalTextField(80,6.5,"Code",verificationCodeController.code,Text(""),"assets/icons/verification_code.svg",verificationCodeController.verifyValidate.value,context),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        verificationCodeController.resend(context);
                      },
                      child: Container(
                          width: AppStyle.getDeviceWidthPercent(75, context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("resend",
                                style: TextStyle(
                                  color: AppStyle.grey,
                                  fontSize: 14
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                        text: "Submit",
                        onPressed: () {
                          verificationCodeController.verify(context);
                        },
                        color: AppStyle.primary,
                        borderRadius: 30,
                        border: AppStyle.primary,
                        width: AppStyle.getDeviceWidthPercent(80, context),
                        height: AppStyle.getDeviceHeightPercent(6.5, context),
                        textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              verificationCodeController.loading.value ?
              Positioned(child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(color: AppStyle.primary,),
                ),
              )) : Center()
            ],
          ),
        ))
    );
  }

  normalTextField(double width,double height,String text,TextEditingController controller,Widget suffix,String prefix,bool validate,BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width * (width / 100),
      height: MediaQuery.of(context).size.height * (height / 100),
      child: TextField(
        controller: controller,
        cursorColor: AppStyle.darkGrey,
        style: TextStyle(color: AppStyle.darkGrey,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Container(
            width: 60,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SvgPicture.asset(prefix,
                color: AppStyle.darkGrey,),
            ),
          ),
          labelText: text,
          labelStyle: TextStyle(
              color: AppStyle.grey,
              fontSize: CommonTextStyle.mediumTextStyle,
              fontWeight: FontWeight.normal
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: validate ? AppStyle.grey.withOpacity(0.5) : Colors.red),
              borderRadius: BorderRadius.circular(30)
          ),
          focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: validate? AppStyle.primary : Colors.red),
              borderRadius: BorderRadius.circular(30)
          ),
        ),
      ),
    );
  }

}
