import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/const/store.dart';
import 'package:bk9/controller/account_controller.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/controller/shop_controller.dart';
import 'package:bk9/controller/wishlist_controller.dart';
import 'package:bk9/model/brand.dart';
import 'package:bk9/model/login_info.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/model/start_up.dart';
import 'package:bk9/view/custom_search_view.dart';
import 'package:bk9/view/home_screen.dart';
import 'package:bk9/view/intro_screens.dart';
import 'package:bk9/view/main_page.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:bk9/view/product_filter.dart';
import 'package:bk9/view/searchDelgate.dart';
import 'package:bk9/view/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {

  List<Post> banner = <Post>[];
  List<Post> brand = <Post>[];
  List<Post> service = <Post>[];
  List<Post> superCategory = <Post>[];
  List<Post> gallery = <Post>[];
  List<Post> reviews = <Post>[];
  List<Post> events = <Post>[];
  List<Post> blogs = <Post>[];
  List<Post> newArrivals = <Post>[];
  List<Post> offers = <Post>[];
  List<Post> recommended = <Post>[];
  List<Post> bestSellers = <Post>[];
  List<SearchSuggestion> searchSugg = <SearchSuggestion>[];
  Post? aboutHomePage;
  Post? aboutPage;
  ShopController shopController = Get.put(ShopController());
  WishListController wishListController = Get.put(WishListController());
  AddressesController addressesController = Get.put(AddressesController());
  AccountController accountController = Get.put(AccountController());
  var ready = false.obs;
  RxList<BrandInfo> brands = <BrandInfo>[].obs;
  var loading = false.obs;
  var loadingSearch = false.obs;
  var selectedPostFilter = 0.obs;

  @override
  void onInit() async {
    get_data();
    super.onInit();
  }

  login() async {
    LogInInfo? logInInfo = await Store.loadLogInInfo();
    API.is_active = await Store.isActive();
    if (logInInfo != null) {
      await API.login();
    }
    return;
  }

  get_data() {
    API.checkInternet().then((value) async {
      if (value) {
        API.getCompanyId().then((value) async {
          await login();
          StartUp? startUp = await API.startUp();
          if(startUp != null){
            banner = startUp.banners.posts;
            superCategory = startUp.super_category.posts;
            service = startUp.services.posts;
            brand = startUp.brand.posts;
            gallery = startUp.gallary.posts;
            offers = startUp.offers.posts;
            reviews = startUp.reviews.posts;
            events = startUp.events.posts;
            blogs = startUp.blogs.posts;
            recommended = startUp.recomended.posts;
            bestSellers = startUp.best_sellers.posts;
            newArrivals = startUp.newArrivals.posts;
            aboutHomePage = startUp.aboutHomePage.posts.first;
            aboutPage = startUp.aboutPage.posts.first;
            searchSugg = startUp.searchSuggestion!;
          }
          wishListController.getWishlistData();
          addressesController.getAddress();
          Store.loadDiscountCode();
          get_nave();
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          get_data();
        });
      }
    }).catchError((err) {
    });
  }

  get_nave() async {
    superCategory = superCategory;
    banner = banner;
    service = service;
    brand = brand;
    aboutHomePage = aboutHomePage;
    aboutPage = aboutPage;
    gallery = gallery;
    reviews = reviews;
    events = events;
    blogs = blogs;
    newArrivals = newArrivals;
    searchSugg = searchSugg;
    ready.value=true;
    if (API.customer != null) {
      Get.offAll(() => MainPage());
      ready.value=true;
    } else if (API.email.isNotEmpty && API.is_active == false) {
      Get.to(() => VerificationCode());
    } else {
      bool checkIntroScreens = await Store.loadIntroScreen();
      if(checkIntroScreens) {
        Get.offAll(() => HomeScreen());
      } else {
        Get.offAll(() => IntroScreen());
      }
    }
  }

  shopByBrand(BuildContext context,int brand_id,String brand_title){
    loading.value = true;
    API.getProductsByBrand(brand_id).then((value) {
      loading.value = false;
      if(value.isNotEmpty){
        Get.to(ProductFilter(value,brand_title));
      }else{
        AppStyle.errorMsg(context, "This brand has no elements");
      }
    });
  }

  pressedOnSearch(BuildContext context) async {
    final result = await showSearch(
        context: context,
        delegate: SearchTextField(introController: this));
  }

  search(BuildContext context,String query){
    if(query.isNotEmpty){
      loadingSearch.value = true;
      API.customSearch(query).then((value) {
        loadingSearch.value = false;
        if(value != null){
          Get.off(()=>CustomSearchView(value.products.posts,value.services.posts));
        }
      });
    }
  }


}