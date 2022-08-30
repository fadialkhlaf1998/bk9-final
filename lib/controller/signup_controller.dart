import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/const/store.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:bk9/view/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  TextEditingController nameTextField = TextEditingController();
  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
  RxBool showPassword = false.obs;
  Rx<bool> loading = false.obs;
  var emailValidate = true.obs;
  var passValidate= true.obs;
  var fNameValidate = true.obs;
  var lNameValidate = true.obs;

  signUp(BuildContext context,String name,String email,String password) {
    try {
      if(!RegExp(r'\S+@\S+\.\S+').hasMatch(email) || email.isEmpty || password.isEmpty || name.isEmpty|| password.length <6) {
        if(email.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
          emailValidate.value= false;
        }else{
          emailValidate.value= true;
        }
        if(password.isEmpty || password.length<6) {
          if(password.length <6 && password.isNotEmpty) {
            AppStyle.errorMsg(context, "Password must be 6 characters at least");
            passValidate.value= false;
          }
          passValidate.value= false;
        } else {
          passValidate.value= true;
        }
        if(name.isEmpty) {
          fNameValidate.value= false;
        } else {
          fNameValidate.value= true;
        }
      } else {
        API.checkInternet().then((net) {
          if(net){
            loading.value=true;
            API.signUp(name,email,password).then((value) {
              loading.value = false;
              if (value) {
                /// TODO
                Store.saveLogInInfo(email, password, 1.toString());
                API.email = emailTextField.text;
                API.password = passwordTextField.text;
                AppStyle.successMsg(context, "Signup has been successfully");
                Get.off(() => VerificationCode());
              } else {
                loading.value = false;
                AppStyle.errorMsg(context, "This email is already exist");
              }
            });
          } else {
            Get.to(() => NoInternet())!.then((value) {
              signUp(context,name,email,password);
            });
          }
        });
      }
    } catch(e) {
      loading.value= false;
      AppStyle.errorMsg(context, "Something went wrong");
    }
  }

}