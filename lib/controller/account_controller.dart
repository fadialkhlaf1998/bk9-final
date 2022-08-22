import 'package:bk9/const/api.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController {

  RxBool loading = false.obs;
  AddressesController addressesController = Get.find();


  Future pickGalleyImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      API.checkInternet().then((value) async {
        if (value) {
          Get.back();
          loading.value = true;
          API.upload_customer_photo(image.path).then((value) {
            API.login().then((value) {
              loading.value = false;
            });
          });
        } else {
          Get.to(() => NoInternet())!.then((value) {
            Get.off(() => pickGalleyImage());
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    }
  }
  Future pickCameraImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      API.checkInternet().then((value) async {
        if (value) {
          Get.back();
          loading.value = true;
          API.upload_customer_photo(image.path).then((value) {
            API.login().then((value) {
              loading.value = false;
            });
          });
        } else {
          Get.to(() => NoInternet())!.then((value) {
            Get.off(() => pickCameraImage());
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    }
  }
  deleteImage() {
    API.checkInternet().then((value) async {
      if (value) {
        Get.back();
        loading.value = true;
        API.delete_customer_photo(API.customer_id).then((value) {
          API.customer!.image = "";
          loading.value = false;
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          Get.off(() => deleteImage());
        });
      }
    }).catchError((err) {
      loading.value = false;
      err.printError();
    });
  }
  // getOrderHistory(BuildContext context) {
  //   loading.value = true;
  //   API.checkInternet().then((internet) async {
  //     if (internet) {
  //       API.getCustomerOrders(API.customer_id).then((value) {
  //         loading.value = false;
  //         if (value.isNotEmpty) {
  //           // print(value.length);
  //           Get.to(() => CustomerOrderView(value));
  //         } else {
  //           AppStyle.errorMsg(context,"You don't have any orders yet");
  //         }
  //       });
  //     } else {
  //       Get.to(() => NoInternet())!;
  //     }
  //   }).catchError((err) {
  //     loading.value = false;
  //     err.printError();
  //   });
  // }
  // getAddress() {
  //   API.checkInternet().then((internet) {
  //     if(internet) {
  //       loading.value = true;
  //       API.getAddress().then((value) {
  //         if(value.isNotEmpty) {
  //           addressesController.addresses.clear();
  //           addressesController.addresses.addAll(value);
  //           loading.value = false;
  //           Get.to(() => MyAddress());
  //           addressesController.clear();
  //         }else{
  //           loading.value = false;
  //         }
  //       });
  //     }else {
  //       Get.to(() => NoInternet())!.then((value) {
  //         getAddress();
  //       });
  //     }
  //   });
  // }

}