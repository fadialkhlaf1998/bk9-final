import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/change_password_controller.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChangePassword extends StatelessWidget {

  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

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
                          Text("Change Password",
                            style: CommonTextStyle.textStyleForDarkGreyBigButton,
                          ),
                        ],
                      ),
                    ),
                    passwordTextField(80,6.5,"New Password",changePasswordController.newPassword,changePasswordController.validateNewPass.value,context,changePasswordController.showPassword1),
                    SizedBox(height: 15),
                    passwordTextField(80,6.5,"Confirm Password",changePasswordController.confirmPassword,changePasswordController.validateConfNewPass.value,context,changePasswordController.showPassword2),
                    SizedBox(height: 15),
                    CustomButton(
                        text: "Submit",
                        onPressed: () {
                          changePasswordController.changePassword(context, changePasswordController.newPassword.text, changePasswordController.confirmPassword.text);
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
              changePasswordController.loading.value ?
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

  passwordTextField(double width,double height,String text,TextEditingController controller,bool validate,BuildContext context,RxBool obscureText){
    return Container(
      width: MediaQuery.of(context).size.width * (width / 100),
      height: MediaQuery.of(context).size.height * (height / 100),
      child: TextField(
        cursorColor: AppStyle.darkGrey,
        style: TextStyle(color: AppStyle.darkGrey,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
        keyboardType: TextInputType.text,
        obscureText: !obscureText.value,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: text,
          labelStyle: TextStyle(
              color: AppStyle.grey,
              fontSize: CommonTextStyle.mediumTextStyle,
              fontWeight: FontWeight.normal
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: validate? AppStyle.grey.withOpacity(0.5):Colors.red),
              borderRadius: BorderRadius.circular(30)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: validate?AppStyle.primary:Colors.red),
              borderRadius: BorderRadius.circular(30)
          ),
          suffixIcon: !obscureText.isFalse
              ? GestureDetector(
            onTap: (){
              obscureText.value = !obscureText.value;
            },
            child: Container(
                width: 60,
                child: const Icon(Icons.visibility_outlined,size: 23, color: AppStyle.grey)),
          )
              : GestureDetector(
            onTap: (){
              obscureText.value = !obscureText.value;
            },
            child: Container(
                width: 60,
                child: const Icon(Icons.visibility_off_outlined,size: 23, color: AppStyle.grey)),
          ),
          prefixIcon: Container(
            width: 60,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SvgPicture.asset("assets/icons/password.svg",),
            ),
          ),
        ),
      ),
    );
  }

}
