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
  Rx<double> subTotal = 0.0.obs, total = 0.0.obs, shipping = 10.0.obs,
      discount = API.discount.toDouble().obs, coupon = 0.0.obs;
  Rx<bool> loading = false.obs;
  Rx<bool> cart_op_loading = false.obs;
  TextEditingController discountCode = TextEditingController();
  RxDouble allPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCartData();
  }
  getTotal(){
    discount.value = double.parse(API.discount.toString());
    print(discount.value);
    total.value=0;
    subTotal.value=0;
    for(int i=0;i<cart.length;i++){
      int sumAllPrice = cart[i].price + cart[i].additionalPrice;
      int sum = (cart[i].price + cart[i].additionalPrice)*cart[i].count;
      subTotal.value += sum;
      allPrice.value += sumAllPrice.toDouble();
    }
    total.value=((subTotal.value*(100-discount.value))/100)+shipping.value;
  }

  addToCart(Option option, int count, BuildContext context) {
    int oldCount = checkInCart(option);
    int index = getOptionIndex(option);
    print('add to index $index');
    if (option.stock >= (count + oldCount)) {
      if(API.customer_id == -1) {
        Get.to(() => Login());
        return;
      } else {
        if(index>=0){
          cart[index].loading_op.value = true;
        }
        cart_op_loading.value = true;
        API.addToCart(option.id, count).then((value) {
          cart.value = value!;
          if(oldCount>0){
            AppStyle.successMsg(context,"Cart Updated to cart successfully");
          }else{
            AppStyle.successMsg(context,"Product added to cart successfully");
          }
          getTotal();
          cart_op_loading.value =false;
          if(index>=0){
            cart[index].loading_op.value = false;
          }
        });
      }
    } else {
      AppStyle.errorMsg(context,"Out of stock");
      getTotal();
      cart_op_loading.value =false;
      if(index>=0){
        cart[index].loading_op.value = false;
      }
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
  int getOptionIndex(Option option) {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].productOptionsId == option.id) {
        return i;
      }
    }
    return -1;
  }
  increase(Option option, int count, BuildContext context) {
    addToCart(option, count, context);
  }
  decrease(Option option, int count, BuildContext context) {
    print(count);
    if(count>0){
      return;
    }
    int oldCount = checkInCart(option);
    if(oldCount<=count.abs()){
      //todo delete by option
      deleteFromCart(getOptionIndex(option),context);
    }else{
      addToCart(option, count, context);
    }
  }
  deleteFromCart(int index, BuildContext context)async{
    cart_op_loading.value = true;
    cart[index].loading_op.value = true;
    bool succ = await API.deleteFromCart(cart[index].cartId);

    if(succ){
      cart.removeAt(index);
      getTotal();
      cart_op_loading.value = false;
      cart[index].loading_op.value = false;
    }else{
      AppStyle.errorMsg(context,"Something went wrong");
      getTotal();
      cart_op_loading.value = false;
      cart[index].loading_op.value = false;
    }
  }
  getCartData() async {
    Store.loadLogInInfo();
    API.getCart(API.customer_id).then((value){
      cart.addAll(value);
      getTotal();
    });
  }
  clear() {
    cart.clear();
    discount.value = 0.0;
    API.discount = 0;
    getTotal();
  }


}
