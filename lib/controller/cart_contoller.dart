import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/const/store.dart';
import 'package:bk9/model/cart_item.dart';
import 'package:bk9/model/product.dart';
import 'package:bk9/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class CartController extends GetxController {
  RxList<CartItem> cart = <CartItem>[].obs;
  Rx<double> subTotal = 0.0.obs,
      total = 0.0.obs,
      shipping = 0.0.obs,
      discount = 0.0.obs,
      coupon = 0.0.obs;
  Rx<bool> loading = false.obs;
  TextEditingController discountCode = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    getCartData();
  }

  addToCart(Option option, int count, BuildContext context) {
    int oldCount = checkInCart(option);
    if (option.stock >= (count + oldCount)) {
      if(API.customer_id == -1) {
        Get.to(() => Login());
        return;
      } else {
        loading.value = true;
        API.addToCart(option.id, count).then((value) {
          cart.value = value!;
          loading.value =false;
          AppStyle.successMsg(context,"Product added to cart successfully");
        });
      }
    } else {
      AppStyle.errorMsg(context,"Out of stock");
      loading.value =false;
      return false;
    }
  }

  int checkInCart(Option option) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].productOptionsId == option.id) {
        return cart[i].count;
      }
    }
    return 0;
  }

  increase(Option option, int count, BuildContext context) {
    addToCart(option, count, context);
  }

  decrease(Option option, int count, BuildContext context) {
    if(count>0){
      return;
    }
    int oldCount = checkInCart(option);
    if(oldCount>=count.abs()){
      deleteFromCart(option,context);
    }else{
      addToCart(option, count, context);
    }
  }

  deleteFromCart(Option option, BuildContext context)async{
    for(int i=0;i<cart.length;i++){
      if(cart[i].productOptionsId == option.id){
        loading.value = true;
        bool succ = await API.deleteFromCart(cart[i].cartId);
        loading.value = false;
        if(succ){
          cart.remove(i);
        }else{
          AppStyle.errorMsg(context,"Something went wrong");
        }
      }
    }
  }

  getCartData() async {
    Store.loadLogInInfo();
    API.getCart(API.customer_id).then((value){
      cart.addAll(value);
    });
  }

  clear() {
    cart.clear();
    discount.value = 0.0;
  }


}
