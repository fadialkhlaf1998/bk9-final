
import 'package:bk9/model/post.dart';
import 'package:get/get.dart';

class ProductFilterController extends GetxController{
  RxList<Post> posts = <Post>[].obs;
  var loading = false.obs;
}