import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/login_controller.dart';
import 'package:bk9/view/forget_password.dart';
import 'package:bk9/view/signup.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).viewPadding.top - 20),
                  ContainerWithImage(
                    width: AppStyle.getDeviceWidthPercent(40, context),
                    height: AppStyle.getDeviceHeightPercent(25, context),
                    image: "assets/icons/logo.svg",
                    option: 0,
                  ),
                  Container(
                    width: AppStyle.getDeviceWidthPercent(80, context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Login",
                          style: CommonTextStyle.textStyleForDarkGreyBigButton,
                        ),
                        SizedBox(height: 5),
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
                  loginSocial(context),
                  SizedBox(height: 20),
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
                            Get.to(()=> SignUp());
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
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * ((height - 4.7) / 100),),
              child: SvgPicture.asset(prefix,
                color: AppStyle.darkGrey),
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
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * ((height - 4.7) / 100),),
              child: SvgPicture.asset("assets/icons/password.svg",),
            ),
          ),
        ),
      ),
    );
  }
  loginSocial(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppStyle.getDeviceWidthPercent(85, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints constraints) {
                    final boxWidth = constraints.constrainWidth();
                    final dashWidth = 2.0;
                    final dashHeight = 1.5;
                    final dashCount =
                    (boxWidth / (2 * dashWidth)).floor();
                    return Flex(
                      children: List.generate(dashCount, (_) {
                        return SizedBox(
                          width: dashWidth,
                          height: dashHeight,
                          child: DecoratedBox(
                            decoration:
                            BoxDecoration(color: AppStyle.grey.withOpacity(0.7),),
                          ),
                        );
                      }),
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                    );
                  },
                ),
              ),
              Text(" OR ",
                style: TextStyle(
                    color: AppStyle.grey.withOpacity(0.7),
                    fontSize: CommonTextStyle.mediumTextStyle,
                    fontWeight: FontWeight.normal
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints constraints) {
                    final boxWidth = constraints.constrainWidth();
                    final dashWidth = 2.0;
                    final dashHeight = 1.5;
                    final dashCount =
                    (boxWidth / (2 * dashWidth)).floor();
                    return Flex(
                      children: List.generate(dashCount, (_) {
                        return SizedBox(
                          width: dashWidth,
                          height: dashHeight,
                          child: DecoratedBox(
                            decoration:
                            BoxDecoration(color: AppStyle.grey.withOpacity(0.7),),
                          ),
                        );
                      }),
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      direction: Axis.horizontal,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        // GestureDetector(
        //   onTap: () {
        //     /// todo login apple
        //   },
        //   child: Container(
        //     width: AppStyle.getDeviceWidthPercent(80, context),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       border: Border.all(color: AppStyle.grey.withOpacity(0.5)),
        //       borderRadius: BorderRadius.circular(30)
        //     ),
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Image.asset("assets/images/apple-logo.png",width: 23,height: 23),
        //           Text("Continue with Apple",
        //             style: TextStyle(
        //                 color: AppStyle.grey,
        //                 fontSize: CommonTextStyle.mediumTextStyle,
        //                 fontWeight: FontWeight.normal
        //             ),
        //           ),
        //           Container()
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 10,),
        // GestureDetector(
        //   onTap: () {
        //     /// todo login google
        //   },
        //   child: Container(
        //     width: AppStyle.getDeviceWidthPercent(80, context),
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         border: Border.all(color: AppStyle.grey.withOpacity(0.5)),
        //         borderRadius: BorderRadius.circular(30)
        //     ),
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           SvgPicture.asset("assets/icons/google.svg",width: 25,height: 25),
        //           Text("Continue with Google",
        //             style: TextStyle(
        //                 color: AppStyle.grey,
        //                 fontSize: CommonTextStyle.mediumTextStyle,
        //                 fontWeight: FontWeight.normal
        //             ),
        //           ),
        //           Container()
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 10,),
        // GestureDetector(
        //   onTap: () {
        //     /// todo login facebook
        //   },
        //   child: Container(
        //     width: AppStyle.getDeviceWidthPercent(80, context),
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         border: Border.all(color: AppStyle.grey.withOpacity(0.5)),
        //         borderRadius: BorderRadius.circular(30)
        //     ),
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           SvgPicture.asset("assets/icons/facebook.svg",width: 25,height: 25),
        //           Text("Continue with Facebook",
        //             style: TextStyle(
        //                 color: AppStyle.grey,
        //                 fontSize: CommonTextStyle.mediumTextStyle,
        //                 fontWeight: FontWeight.normal
        //             ),
        //           ),
        //           Container()
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
