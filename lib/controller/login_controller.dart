import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/const/store.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/view/main_page.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {

  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
  AddressesController addressesController = Get.find();
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
                addressesController.getAddress();
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


  loginVerify(BuildContext context,String email,String pass){

    try {
      API.checkInternet().then((net) {
        if (net){
          loading.value=true;
          API.password = pass;
          API.email = email;
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
            loginVerify(context,email,pass);
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });

    }catch (e){
      print(e.toString());
      loading.value= false;
      AppStyle.errorMsg(context, "Something went wrong");
    }

  }

  signUpVerifyThenLogIn(BuildContext context,String name , String email ,String pass,String image)async{
    loading.value =true;
    await API.signUpVerify(name, email, pass,image);
    loginVerify(context, email, pass);
  }
  generatePassword(String email) {
      String output = "";
      output = email.replaceAll("a", "m")
      .replaceAll("b", "i")
      .replaceAll("c", "d")
      .replaceAll("d", "g")
      .replaceAll("e", "h")
      .replaceAll("f", "w")
      .replaceAll("g", "r")
      .replaceAll("h", "j")
      .replaceAll("i", "q")
      .replaceAll("j", "p")
      .replaceAll("k", "z")
      .replaceAll("l", "s")
      .replaceAll("m", "t")
      .replaceAll("n", "y")
      .replaceAll("o", "j")
      .replaceAll("p", "s")
      .replaceAll("q", "b")
      .replaceAll("r", "c")
      .replaceAll("s", "k")
      .replaceAll("t", "e")
      .replaceAll("u", "l")
      .replaceAll("w", "a")
      .replaceAll("y", "b")
      .replaceAll("z", "m");
    return output;
  }
  googleSignIn(BuildContext context)async{
    GoogleSignIn googleSignIn = GoogleSignIn();
    var googleData = await googleSignIn.signIn();
    if(googleData != null){
      String email = googleData.email;
      String pass = generatePassword(googleData.email.split("@")[0]);
      // print(pass);
      // print(generatePassword(pass));
      signUpVerifyThenLogIn(context,googleData.displayName??"", email, pass, googleData.photoUrl??"");
    }else{
      AppStyle.errorMsg(context, "oops SomeThing Went Wrong");
    }
  }

  appleSignIn(BuildContext context)async{
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    if(credential.email != null){
      // AppStyle.successMsg(context, credential.email!);
      String email = credential.email!;
      String pass =  generatePassword(credential.email!.split("@")[0]);
      String name = "";
      if(credential.givenName !=null && credential.familyName !=null){
        name = credential.givenName! +" "+credential.familyName!;
      }
      signUpVerifyThenLogIn(context,name, email, pass,"");
    }else if(credential.identityToken != null){
      // AppStyle.successMsg(context, credential.identityToken!.substring(0,15));
      String email = credential.identityToken!.substring(0,15);
      String pass =  generatePassword(credential.identityToken!.substring(0,15));
      String name = "";
      if(credential.givenName !=null && credential.familyName !=null){
        name = credential.givenName! +" "+credential.familyName!;
      }
      signUpVerifyThenLogIn(context,name, email, pass,"");
    }else{
      AppStyle.errorMsg(context, "oops SomeThing Went Wrong");
    }


  }
  facebookSignIn(BuildContext context)async{
    //todo  facebook
    final result = await FacebookAuth.i.login(permissions: ["public_profile","email"]);
    if(result.status == LoginStatus.success){
      final credential = await FacebookAuth.i.getUserData();
      print(credential);
      if(credential['email'] != null){
        String email = credential['email'];
        String pass = generatePassword(credential['email'].split("@")[0]);
        String name = "";
        if(credential['name'] !=null ){
          name = credential['name'];
        }
        signUpVerifyThenLogIn(context,name, email, pass, credential['picture']['data']['url']??"");
      }else{
        AppStyle.errorMsg(context, "oops SomeThing Went Wrong");
      }
    }else{
      AppStyle.errorMsg(context, "oops SomeThing Went Wrong");
    }
  }
}