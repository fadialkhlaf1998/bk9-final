import 'package:bk9/const/api.dart';
import 'package:bk9/view/product_info.dart';
import 'package:get/get.dart';

class NewArrivalsController extends GetxController {

  RxBool loading = false.obs;

  goToProductPage(int productId){
    Get.to(()=> ProductInformation(productId));
    // loading.value = true;
    // API.checkInternet().then((internet) {
    //   if(internet) {
    //     API.getProductInfo(productId).then((value) {
    //       Get.to(()=> ProductInformation(value!.product![0]));
    //       loading.value = false;
    //     });
    //   }
    // });
  }
}