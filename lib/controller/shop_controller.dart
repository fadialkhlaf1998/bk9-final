import 'package:bk9/const/api.dart';
import 'package:bk9/model/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopController extends GetxController{

  Rx<int> selectedSuperCategory = 0.obs;
  Rx<int> selectedCategory = 0.obs;
  Rx<int> selectedSubCategory = 0.obs;
  RxBool loading = false.obs;
  RxList<Post> productsView = <Post>[].obs;

  ///sort sate 0 newest | 1 top rated | 2 lowes price | 3 highest price
  Rx<int> sort_state = 0.obs;

  List<Post> sort(List<Post> posts){
    if(sort_state.value == 0){
      posts.sort((a,b)=>a.id.compareTo(b.id));
    }
    else if(sort_state.value == 1){
      posts.sort((a,b)=>a.rate.compareTo(b.price));
    }
    else if(sort_state.value == 2){
      posts.sort((a,b)=>a.price.compareTo(b.price));
    }
    else if(sort_state.value == 3){
      posts.sort((a,b)=>a.price.compareTo(b.price));
      posts = posts.reversed.toList();
    }
    return posts;
  }

  ///filter
  List<Post> posts = <Post>[];
  RxList<Post> postsView = <Post>[].obs;
  var openCollection = false.obs;
  var openPrice = false.obs;
  var openClearFilter = false.obs;
  Rx<RangeLabels> priceLabel = const RangeLabels("AED 0.00", "AED 5000.00").obs;
  Rx<double> minPrice=0.0.obs,maxPrice=99999999999999999999.0.obs;
  Rx<RangeValues> price = const RangeValues(0, 5000).obs;

  @override
  void onInit() async{
    posts = await API.getPostByPostType(27);
    postsView = List<Post>.from(posts).obs;
    super.onInit();
  }

  filterPost(int category){
    openClearFilter.value = true;
    selectedCategory.value = category;
    List<Post> temp = <Post>[];
    for(int i=0;i<posts.length;i++){
      if((category==-1||posts[i].parent1==category)&&posts[i].price>=minPrice.value&&posts[i].price<=maxPrice.value){
        temp.add(posts[i]);
      }
    }
    postsView = List<Post>.from(temp).obs;
    return;
  }
  clearFilter(){
    openClearFilter.value = false;
    openPrice.value = false;
    openCollection.value = false;
    minPrice.value = 0.0;
    maxPrice.value = 5000.00;
    price.value = const RangeValues(0.0, 5000.0);
    priceLabel.value = const RangeLabels("AED 0.00", "AED 5000.00");
    postsView = List<Post>.from(posts).obs;
  }


}