import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  Rx<bool> emailValidate = true.obs;
  Rx<bool> loading = false.obs;

  TextEditingController email = TextEditingController();

  forgetPassword(BuildContext context,String email) {
    try{
      if(email.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
        if(email.isEmpty) {
          AppStyle.errorMsg(context, "Please enter your email");
          emailValidate.value=false;
        }
      } else{
        API.checkInternet().then((value) async {
          if (value) {
            loading.value = true;
            API.forgot_password(email).then((value) {
              loading.value = false;
              if (value) {
                AppStyle.successMsg(context,"Password send to Email Successfully");
                Get.back();
              } else {
                loading.value = false;
                AppStyle.errorMsg(context,"Something went wrong");
              }
            });
          } else {
            Get.to(() => NoInternet())!.then((value) {
              forgetPassword(context,email);
            });
          }
        }).catchError((err) {
          loading.value = false;
          err.printError();
        });
      }
    }catch(e){
      loading.value=false;
      AppStyle.errorMsg(context,"Something went wrong");
    }
  }
}
