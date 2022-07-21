import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/view/home.dart';
import 'package:bk9/view/main_page.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class VerificationCodeController extends GetxController {
  Rx<bool> verifyValidate = true.obs;
  Rx<bool> fake = false.obs;
  Rx<bool> loading = false.obs;

  TextEditingController code = TextEditingController();

  verify(BuildContext context) {
    if (code.text.isNotEmpty) {
      API.checkInternet().then((value) async {
        if (value) {
          loading.value = true;
          API.verify(API.email,code.text).then((value) {
            if (value) {
              API.login().then((value) {
                loading.value = false;
                AppStyle.successMsg(context,"Account has been verified successfully");
                Get.offAll(() => MainPage());
              });
            } else {
              loading.value = false;
              AppStyle.errorMsg(context,"This code is wrong please try again");
            }
          });
        } else {
          Get.to(() => NoInternet())!.then((value) {
            verify(context);
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    } else {
      verifyValidate.value = false;
    }
  }

  resend(BuildContext context) {
    if (API.email.isNotEmpty) {
      API.checkInternet().then((value) async {
        if (value) {
          loading.value = true;
          API.resendCode(API.email).then((value) {
            loading.value = false;
            if (value) {
              AppStyle.successMsg(context,"Code has been sent to your email successfully");
            } else {
              loading.value = false;
              AppStyle.errorMsg(context,"Code not sent some thing went wrong");
            }
          });
        } else {
          Get.to(() => NoInternet())!.then((value) {
            verify(context);
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    }
  }
}
