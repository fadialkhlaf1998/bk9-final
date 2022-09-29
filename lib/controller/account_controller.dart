import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/const/store.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountController extends GetxController {

  RxBool loading = false.obs;
  RxBool discountCodeLoading = false.obs;
  AddressesController addressesController = Get.find();
  TextEditingController voucherCode = TextEditingController();
  var codeValidate = true.obs;
  RxBool visibleFloatingButton = false.obs;

  /// map
  late GoogleMapController googleMapController;
  final initialCameraPosition = CameraPosition(
    target: LatLng(Store.latitude, Store.longitude),
    zoom: 11.5,
  );
  Set<Marker> marker = Set();
  void onMapCreated(GoogleMapController controller)  async {
    marker.add(
        Marker(
            markerId: MarkerId('id-1'),
            position: LatLng(Store.latitude, Store.longitude),
             visible: true,
          icon: BitmapDescriptor.defaultMarker,
        ));
  }
  void openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/place/The+Barkley+Pet+Camp/@25.1774539,55.3645627,17z/data=!3m1!4b1!4m5!3m4!1s0x3e5f671870b004a3:0xd105f08f9c4285cc!8m2!3d25.1774539!4d55.3645627';
    await launchUrl(Uri.parse(googleUrl));
  }


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
  activeDiscount(BuildContext context) {
    API.checkInternet().then((value) async {
      if (value) {
        discountCodeLoading.value = true;
        if(voucherCode.text.isNotEmpty) {
          API.activeDiscount(voucherCode.text).then((value) {
            discountCodeLoading.value = false;
            voucherCode.text = "";
          });
        } else {
          AppStyle.errorMsg(context, "please enter the code first");
          discountCodeLoading.value = false;
        }
      } else {
        Get.to(() => NoInternet())!.then((value) {
          Get.off(() => activeDiscount(context));
        });
      }
    }).catchError((err) {
      discountCodeLoading.value = false;
      err.printError();
    });
  }
  deleteAccount(){
    API.checkInternet().then((value) async {
      if (value) {
        Get.back();
        loading.value = true;
        API.delete_account(API.customer!.id).then((value) {
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
}