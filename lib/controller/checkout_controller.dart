import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/controller/cart_contoller.dart';
import 'package:bk9/view/main_page.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {

  var loading = false.obs;
  var shippingMethod = 0.obs;
  var paymentMethod = 0.obs;
  var selectAddress = 0.obs;
  var shippingValidate = false.obs;
  var paymentValidate = false.obs;
  var addressValidate = false.obs;
  var selected = 0.obs;
  var selectValue = false.obs;
  String phonePref = "+971";
  CartController cartController = Get.find();
  AddressesController addressesController = Get.find();


  next(BuildContext context){
    if(selected.value == 0){
      if(shippingValidate.value && paymentValidate.value){
        selectValue.value = true;
      }else{
        selected.value ++;
      }
    }else{
      if(!selectValue.value) {
        if(addressValidate.value){
          selectValue.value = true;
        }else{
          addOrder(context, 0);
        }
      }else if(selectValue.value){
        selected.value ++;
      }
    }
  }
  back(){
    selectValue.value = false;
    if(selected.value == 0) {
      Get.back();
    }else if(selected.value == 1){
      selected.value --;
    }else {
      selected.value --;
    }
  }

  addOrder(BuildContext context, int isPaid,) {
    loading.value = true;
    API.checkInternet().then((value) async {
      if (value) {
        API.addOrder(addressesController.nickName.text, addressesController.adddress1.text,
            addressesController.adddress2.text,phonePref + " " + addressesController.phone.text,
            addressesController.country.value,addressesController.apartment.text + " " + addressesController.emirate.value,
            cartController.total.value,
            cartController.subTotal.value,
            cartController.shipping.value,
            cartController.coupon.value,
            isPaid,
            cartController.cart.value).then((value) {
              loading.value = false;
              if (value) {
                cartController.clear();
                AppStyle.successMsg(context, "Order Placed Successfully");
                Get.offAll(() => MainPage());
              } else {
                AppStyle.errorMsg(context, "something went wrong");
              }
            });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          addOrder(context, isPaid);
        });
      }
    }).catchError((err) {
      loading.value = false;
      err.printError();
    });
  }

}
