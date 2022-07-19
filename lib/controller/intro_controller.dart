import 'package:bk9/view/home_screen.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {


  @override
  void onInit() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Get.to(() => HomeScreen());
    });
    super.onInit();
  }
}