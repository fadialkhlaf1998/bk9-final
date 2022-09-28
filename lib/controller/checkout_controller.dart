import 'dart:convert';

import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/controller/cart_contoller.dart';
import 'package:bk9/model/cart_item.dart';
import 'package:bk9/view/main_page.dart';
import 'package:bk9/view/my_address.dart';
import 'package:bk9/view/my_fatoraah.dart';
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
      if(shippingMethod.value == 0) {
        selected.value ++ ;
      }else{
        if(paymentMethod.value == 1){
          selected.value  = 0 ;
          Get.to(()=>MyFatoraahPage("BK9", cartController.total.value.toString()));
          // selected.value = 2 ;
        }else{
          addOrder(context, paymentMethod.value);
        }
      }
    }else {
      if(paymentMethod.value == 1){
        selected.value  = 0 ;
        Get.to(()=>MyFatoraahPage("BK9", cartController.total.value.toString()));
      }else{
        addOrder(context, 0);
      }
    }
  }


  back(){
    if(selected.value == 0){
      Get.back();
    }
    selected.value -- ;
  }

  addOrder(BuildContext context, int isPaid) {
    loading.value = true;
    List<CartItem> cart = <CartItem>[];
    for(int i = 0 ; i < cartController.cart.value.length ; i ++){
      if(cartController.cart[i].count <=0){
        cartController.cart.removeAt(i);
      }
    }
    print("cartController.cart.value.length");
    print(cartController.cart.value.length);
    if(cartController.cart.value.length > 0){
      API.checkInternet().then((value) async {
        if (value) {
          if(shippingMethod.value == 2){
            API.addOrder(API.customer!.firstname, "",
                "","",
                "","",
                cartController.total.value-cartController.shipping.value,
                cartController.subTotal.value,
                0,
                cartController.coupon.value,
                isPaid,
                cartController.cart.value,shippingMethod.value).then((value) {
              loading.value = false;
              if (value) {
                cartController.clear();
                AppStyle.successMsg(context, "Order Placed Successfully");
                Get.offAll(() => MainPage());
              } else {
                addOrder(context,isPaid);
              }
            });
          }else{

            API.addOrderByAddressId(addressesController.addresses[selectAddress.value].id,API.customer!.firstname,
                cartController.total.value,
                cartController.subTotal.value,
                cartController.shipping.value,
                cartController.coupon.value,
                isPaid,
                cartController.cart.value,shippingMethod.value).then((value) {
              loading.value = false;
              if (value) {
                cartController.clear();
                AppStyle.successMsg(context, "Order Placed Successfully");
                Get.offAll(() => MainPage());
              } else {
                addOrder(context,isPaid);
              }
            });
          }

        } else {
          Get.to(() => NoInternet())!.then((value) {
            addOrder(context, isPaid);
          });
        }
      }).catchError((err) {
        loading.value = false;
        err.printError();
      });
    }else{
      AppStyle.errorMsg(context, "Oops Something Went Wrong");
    }

  }

}
