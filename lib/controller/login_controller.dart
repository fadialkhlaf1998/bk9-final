import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/view/main_page.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {

  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
  RxBool showPassword = false.obs;
  Rx<bool> emailValidate = true.obs;
  Rx<bool> passwordValidate = true.obs;
  Rx<bool> loading = false.obs;
  String secrit = "BraklYMaXaRT2022";

  login(BuildContext context,String email,String pass){
    try {
      if(email.isEmpty || pass.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
        if(email.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
          emailValidate.value= false;
        }
        if(pass.isEmpty){
          passwordValidate.value= false;
        }
      }else{
        API.checkInternet().then((net) {
          if (net){
            loading.value=true;
            API.email = emailTextField.text;
            API.password = passwordTextField.text;
            API.login().then((value) {
              loading.value = false;
              if (value != null) {
                AppStyle.successMsg(context,"Login has been successfully");
                Get.offAll(() => MainPage());
              } else {
                loading.value=false;
                AppStyle.errorMsg(context, "Wrong Email or Password please try again");
              }
            });
          } else {
            Get.to(() => NoInternet())!.then((value) {
              login(context,email,pass);
            });
          }
        }).catchError((err) {
          loading.value = false;
          err.printError();
        });
      }

    }catch (e){
      print(e.toString());
      loading.value= false;
      AppStyle.errorMsg(context, "Something went wrong");
    }
  }

  signUpVerifyThenLogIn(BuildContext context,String name , String email ,String pass,String image)async{
    loading.value =true;
    await API.signUpVerify(name, email, pass,image);
    login(context, email, pass);
  }

  googleSignIn(BuildContext context)async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    var googleData = await googleSignIn.signIn();
    if(googleData != null){
      String email = googleData.email;
      String pass = googleData.email.split("@")[0]+secrit;
      signUpVerifyThenLogIn(context,googleData.displayName??"", email, pass, googleData.photoUrl??"");
    }else{
      AppStyle.errorMsg(context, "oops SomeThing Went Wrong");
    }
  }

}