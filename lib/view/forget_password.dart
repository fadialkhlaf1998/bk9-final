import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/forgot_password_controller.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class ForgetPassword extends StatelessWidget {

  ForgetPasswordController forgotPasswordController = Get.put(ForgetPasswordController());

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
                              Icon(Icons.arrow_back_ios,size: 23,color: AppStyle.darkGrey,),
                            ],
                          )
                      ),
                    ),
                    ContainerWithImage(
                      width: AppStyle.getDeviceWidthPercent(40, context),
                      height: AppStyle.getDeviceHeightPercent(25, context),
                      image: "assets/icons/logo.svg",
                      option: 0,
                    ),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(80, context),
                      // height: AppStyle.getDeviceHeightPercent(5.5, context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Forget Password",
                            style: CommonTextStyle.textStyleForDarkGreyBigButton,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    normalTextField(80,6.5,"Email",forgotPasswordController.email,Text(""),"assets/icons/email.svg",2,forgotPasswordController.emailValidate.value,context),
                    SizedBox(height: 15),
                    CustomButton(
                        text: "Submit",
                        onPressed: () {
                          forgotPasswordController.forgetPassword(context,forgotPasswordController.email.text);
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
              forgotPasswordController.loading.value ?
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

  normalTextField(double width,double height,String text,TextEditingController controller,Widget suffix,String prefix,int maxLength,bool validate,BuildContext context){
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
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * ((height - 4.7) / 100),),
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
