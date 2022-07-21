import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class ChangePasswordController extends GetxController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool showPassword1 = false.obs;
  RxBool showPassword2 = false.obs;
  var validateNewPass = true.obs;
  var validateConfNewPass = true.obs;
  Rx<bool> loading = false.obs;

  changePassword(BuildContext context,String newPass,String confPass) {
    if(newPass.isEmpty || confPass.isEmpty) {
      if(newPass.isEmpty) {
        validateNewPass.value= false;
      }else{
        validateNewPass.value= true;
      }
      if(confPass.isEmpty) {
        validateConfNewPass.value= false;
      }else{
        validateConfNewPass.value= true;
      }
    } else {
      if(newPass==confPass && newPass.length >= 6) {
        API.checkInternet().then((value) async {
          if (value) {
            loading.value = true;
            API.change_password(newPassword.text).then((value) {
              loading.value = false;
              if (value) {
                AppStyle.successMsg(context,"Password has been changed successfully");
                Get.back();
              } else {
                loading.value = false;
                AppStyle.errorMsg(context, "Something went error");
              }
            });
          } else {
            Get.to(() => NoInternet())!.then((value) {
              changePassword(context,newPass,confPass);
            });
          }
        }).catchError((err) {
          loading.value = false;
          err.printError();
        });
      } else {
        if(newPass.length < 6) {
          AppStyle.errorMsg(context, "Password must be 6 characters at least");
        }else if(confPass.length < 6) {
          AppStyle.errorMsg(context, "Password must be 6 characters at least");
        }else {
          AppStyle.errorMsg(context, "Password not same confirm password");
        }
      }
    }
  }
}
