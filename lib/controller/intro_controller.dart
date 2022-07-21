import 'package:bk9/const/store.dart';
import 'package:bk9/view/home_screen.dart';
import 'package:bk9/view/intro_screens.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {


  @override
  void onInit() async {
    bool checkIntroScreens = await Store.loadIntroScreen();
    /// todo get data form api
    if(checkIntroScreens) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        Get.to(() => HomeScreen());
      });
    } else {
      Get.to(() => IntroScreen());
    }
    super.onInit();
  }
}