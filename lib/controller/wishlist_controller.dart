import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/const/store.dart';
import 'package:bk9/model/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {

  RxList<Post> wishlist = <Post>[].obs;
  var loading = false.obs;
  var fake = false.obs;

  @override
  void onInit() {
    super.onInit();
    getWishlistData();
  }

  wishlistFunction(Post post, BuildContext context) {
    if (API.customer_id != -1) {
      if (post.favorite.value) {
        deleteFromWishlist(post);
      } else {
        addToWishlist(post);
      }
    } else {
      AppStyle.errorMsg(context, "Please login first");
    }
  }

  addToWishlist(Post post) {
    post.favorite.value = true;
    wishlist.add(post);
    API.addToWishlist(post.id).then((value) {
    });
  }

  deleteFromWishlist(Post post) {
    post.favorite.value = false;
    print(wishlist.length);
    deleteById(post.id);
    print(wishlist.length);
    API.deleteFromWishlist(post.id);
  }

  int getWishlistIndex(Post post) {
    for (int i = 0; i < wishlist.length; i++) {
      if (wishlist[i].id == post.id) {
        return i;
      }
    }
    return -1;
  }

  getWishlistData() async {
    Store.loadLogInInfo();
    API.getWishlist(API.customer_id).then((value){
      wishlist.addAll(value);
    });
  }

  bool refreshProduct(List<Post> products){
    if(wishlist.isNotEmpty){
      for(int i=0;i<products.length;i++){
        for(int j=0;j<wishlist.length;j++){
          if(products[i].id==wishlist[j].id){
            products[i].favorite.value=true;
            print('*************');
            print(products[i].favorite.value);
            break;
          }else{
            print('********------*******');
            print(products[i].favorite.value);
            products[i].favorite.value=false;
          }
        }
      }
    }else{
      for(int i=0;i<products.length;i++){
        products[i].favorite.value=false;
      }
    }

    return true;
  }

  deleteById(int id){
    for(int i=0;i<wishlist.length;i++){
      if(id == wishlist[i].id){
        wishlist.removeAt(i);
        return;
      }
    }
  }
}
