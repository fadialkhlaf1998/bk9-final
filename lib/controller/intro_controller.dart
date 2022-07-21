import 'package:bk9/const/api.dart';
import 'package:bk9/const/store.dart';
import 'package:bk9/controller/account_controller.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/controller/shop_controller.dart';
import 'package:bk9/controller/wishlist_controller.dart';
import 'package:bk9/model/login_info.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/model/start_up.dart';
import 'package:bk9/view/home_screen.dart';
import 'package:bk9/view/intro_screens.dart';
import 'package:bk9/view/main_page.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:bk9/view/verification_code.dart';
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
  List<Post> bestSellers = <Post>[];
  Post? aboutHomePage;
  Post? aboutPage;
  ShopController shopController = Get.put(ShopController());
  WishListController wishListController = Get.put(WishListController());
  AddressesController addressesController = Get.put(AddressesController());
  AccountController accountController = Get.put(AccountController());

  var ready = false.obs;


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
        API.getCompanyIdTo().then((value) {
          API.getCompanyId().then((value) async {
            await login();
            StartUp? startUp = await API.startUp();
            if(startUp != null){
              banner = startUp.banners.posts;
              superCategory = startUp.super_category.posts;
              service = startUp.services.posts;
              brand = startUp.brand.posts;
              gallery = startUp.gallary.posts;
              reviews = startUp.reviews.posts;
              events = startUp.events.posts;
              blogs = startUp.blogs.posts;
              bestSellers = startUp.best_sellers.posts;
              aboutHomePage = startUp.aboutHomePage.posts.first;
              aboutPage = startUp.aboutPage.posts.first;
            }
            wishListController.getWishlistData();
            addressesController.getAddress();
            get_nave();
          });
        });
      } else {
        Get.to(() => NoInternet())!.then((value) {
          get_data();
        });
      }
    }).catchError((err) {
      // print(err.toString());
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
    bestSellers = bestSellers;
    ready.value=true;
    if (API.email.isNotEmpty && API.is_active == true) {
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

}