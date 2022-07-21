import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/login_controller.dart';
import 'package:bk9/view/forget_password.dart';
import 'package:bk9/view/signup.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  LoginController loginController = Get.put(LoginController());

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
                      children: [
                        Text("Login",
                          style: CommonTextStyle.textStyleForDarkGreyBigButton,
                        ),
                        Text("Enter you email and password",
                            style: CommonTextStyle.textStyleForGreySmallButton
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      normalTextField(80,6.5,"Email",loginController.emailTextField,Text(""),"assets/icons/email.svg",loginController.emailValidate.value,context),
                      SizedBox(height: 15),
                      Obx((){
                        return passwordTextField(80,6.5,"password",loginController.passwordTextField,loginController.passwordValidate.value,context);
                      })
                    ],
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ForgetPassword());
                    },
                    child: Container(
                        width: AppStyle.getDeviceWidthPercent(75, context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("forget password?",
                              style: TextStyle(
                                  color: AppStyle.grey,
                                  fontSize: 14
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 15,),
                  CustomButton(
                      text: "Login",
                      onPressed: () {
                        loginController.login(context,loginController.emailTextField.text,loginController.passwordTextField.text);
                      },
                      color: AppStyle.primary,
                      borderRadius: 30,
                      border: AppStyle.primary,
                      width: AppStyle.getDeviceWidthPercent(80, context),
                      height: AppStyle.getDeviceHeightPercent(6.5, context),
                      textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: AppStyle.getDeviceWidthPercent(85, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don’t have an account? ",
                            style: TextStyle(
                                color: AppStyle.grey,
                                fontSize: 15
                            )
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.off(()=> SignUp());
                          },
                          child: Text("Sign Up",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
            loginController.loading.value ?
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
  passwordTextField(double width,double height,String text,TextEditingController controller,bool validate,BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width * (width / 100),
      height: MediaQuery.of(context).size.height * (height / 100),
      child: TextField(
        cursorColor: AppStyle.darkGrey,
        style: TextStyle(color: AppStyle.darkGrey,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
        keyboardType: TextInputType.text,
        obscureText: !loginController.showPassword.value,
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
          suffixIcon: !loginController.showPassword.isFalse
              ? GestureDetector(
            onTap: (){
              loginController.showPassword.value = !loginController.showPassword.value;
            },
            child: Container(
                width: 60,
                child: const Icon(Icons.visibility_outlined,size: 23, color: AppStyle.grey)),
          )
              : GestureDetector(
            onTap: (){
              loginController.showPassword.value = !loginController.showPassword.value;
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
