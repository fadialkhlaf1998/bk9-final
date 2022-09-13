import 'package:bk9/model/post.dart';
import 'package:get/get.dart';

class ShopController extends GetxController{

  Rx<int> selectedSuperCategory = 0.obs;
  Rx<int> selectedCategory = 0.obs;
  Rx<int> selectedSubCategory = 0.obs;
  RxBool loading = false.obs;
  RxBool fake = false.obs;
  RxList<Post> productsView = <Post>[].obs;

  ///sort sate 0 newest | 1 top rated | 2 lowes price | 3 highest price
  Rx<int> sort_state = 0.obs;

  List<Post> sort(List<Post> posts){
    if(sort_state.value == 0){
      posts.sort((a,b)=>a.id.compareTo(b.id));
    }
    else if(sort_state.value == 1){
      posts.sort((a,b)=>a.rate.compareTo(b.rate));
      posts = posts.reversed.toList();
    }
    else if(sort_state.value == 2){
      posts.sort((a,b)=>a.price.compareTo(b.price));
    }
    else if(sort_state.value == 3){
      posts.sort((a,b)=>a.price.compareTo(b.price));
      posts = posts.reversed.toList();
    }
    fake.value = !fake.value;
    return posts;
  }

}