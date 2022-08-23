import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/signup_controller.dart';
import 'package:bk9/view/login.dart';
import 'package:bk9/view/privacy_policy.dart';
import 'package:bk9/view/terms_of_use.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  SignUpController signUpController = Get.put(SignUpController());

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
                          Text("Sign Up",
                            style: CommonTextStyle.textStyleForDarkGreyBigButton,
                          ),
                          SizedBox(height: 5),
                          Text("Enter your credentials to continue",
                              style: CommonTextStyle.textStyleForGreySmallButton
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        normalTextField(80,6.5,"Name",signUpController.nameTextField,Text(""),"assets/icons/profile.svg",signUpController.fNameValidate.value,context),
                        // SizedBox(height: 15),
                        // normalTextField(80,6.5,"Last Name",signUpController.lastNameTextField,Text(""),"assets/icons/profile.svg",signUpController.lNameValidate.value,context),
                        SizedBox(height: 15),
                        normalTextField(80,6.5,"Email",signUpController.emailTextField,Text(""),"assets/icons/email.svg",signUpController.emailValidate.value,context),
                        SizedBox(height: 15),
                        Obx((){
                          return passwordTextField(80,6.5,"password",signUpController.passwordTextField,signUpController.passValidate.value,context);
                        })
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(80, context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                            text: TextSpan(
                                text: 'By selecting Agree and Continue below, I agree to The Barkley''s',
                                style: TextStyle(color: AppStyle.grey,fontSize: CommonTextStyle.tinyTextStyle,),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: ' Terms of Use',
                                    style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
                                    recognizer: TapGestureRecognizer()..onTap = () =>  Get.to(() => TermsOfUse()),
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: TextStyle(color: AppStyle.grey,fontWeight: FontWeight.normal,fontSize: CommonTextStyle.tinyTextStyle),
                                  ),
                                  TextSpan(
                                      text: 'Privacy Policy.',
                                      style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
                                    recognizer: TapGestureRecognizer()..onTap = () =>  Get.to(() => PrivacyPolicy()),
                                  )
                                ]
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    CustomButton(
                        text: "Agree and Continue",
                        onPressed: () {
                          signUpController.signUp(context,signUpController.nameTextField.text,
                             signUpController.emailTextField.text,signUpController.passwordTextField.text);
                        },
                        color: AppStyle.primary,
                        borderRadius: 30,
                        border: AppStyle.primary,
                        width: AppStyle.getDeviceWidthPercent(80, context),
                        height: AppStyle.getDeviceHeightPercent(6.5, context),
                        textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(85, context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ",
                              style: TextStyle(
                                  color: AppStyle.grey,
                                  fontSize: 15
                              )
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.off(()=> Login());
                            },
                            child: Text("Login",
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
                    SizedBox(height: 20,)
                  ],
                ),
              ),
              signUpController.loading.value ?
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
        obscureText: !signUpController.showPassword.value,
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
          suffixIcon: !signUpController.showPassword.isFalse
              ? GestureDetector(
            onTap: (){
              signUpController.showPassword.value = !signUpController.showPassword.value;
            },
            child: Container(
                width: 60,
                child: const Icon(Icons.visibility_outlined,size: 23, color: AppStyle.grey)),
          )
              : GestureDetector(
            onTap: (){
              signUpController.showPassword.value = !signUpController.showPassword.value;
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

}
