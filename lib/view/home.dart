import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/home_controller.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/view/home_screen.dart';
import 'package:bk9/view/wishlist.dart';
import 'package:bk9/view/events_blogs.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/custom_container.dart';
import 'package:bk9/widgets/custom_gridView_services.dart';
import 'package:bk9/widgets/custom_listView_brands.dart';
import 'package:bk9/widgets/custom_listView_container.dart';
import 'package:bk9/widgets/search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  IntroController introController = Get.find();
  // var loading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 170,),
                  home(context)
                ],
              ),
            ),
            introController.loading.value ?
            Positioned(child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(color: AppStyle.primary,),
              ),
            )) : Center(),
            Positioned(
              top: 0,
              child: _header(context),
            ),
          ],
        )
    ));
  }
  home(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        _imagesSlider(context),
        SizedBox(height: 15),
        API.customer_id == -1 ?
        CustomButton(
            text: "Login / Sign Up",
            onPressed: () {
              Get.off(() => HomeScreen());
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeBigButton
        ) : Text(""),
        SizedBox(height: API.customer_id == -1 ? 25 :  0),
        Container(
          width: AppStyle.getDeviceWidthPercent(90, context),
          child: Text("Services",
              style: CommonTextStyle.textStyleForDarkGreyBigButton
          ),
        ),
        _servicesList(context,introController,homeController.selectedServices.value),
        _brands(context,introController),
        SizedBox(height: 20),
        Container(
            width: AppStyle.getDeviceWidthPercent(90, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Bolgs and Events",
                    style: CommonTextStyle.textStyleForDarkGreyBigButton
                ),
                GestureDetector(
                  onTap: () {
                    /// News and Events page
                    Get.to(()=>EventsBlogs(introController.events,introController.blogs));
                  },
                  child: Text("view all",
                      style: CommonTextStyle.textStyleForWhiteMediumButton
                  ),
                )
              ],
            )
        ),
        SizedBox(height: 20),
        _blogsAndEventsList(context),
        SizedBox(height: 20),
      ],
    );
  }
  _header(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(100, context),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 1,
            offset: Offset(5.0, 5.0,),
          )
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top),
          Container(
            width: AppStyle.getDeviceWidthPercent(95, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ContainerWithImage(
                        width: 80,
                        height: 80,
                        image: "assets/icons/logo.svg",
                        option: 0),
                    Container(
                      height: 70,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: const VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                        indent: 5,
                        endIndent: 0,
                        width: 20,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("THE",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              letterSpacing: 0.5
                          ),
                        ),
                        Text("BARKLEY",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5
                          ),),
                        SizedBox(height: 6)
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => Wishlist());
                    },
                    child: ContainerWithImage(
                        width: 40,
                        height: 70,
                        image: "assets/icons/wishlist.svg",
                        color: AppStyle.grey,
                        option: 0)
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Search(width: AppStyle.getDeviceWidthPercent(90, context),introController: introController,),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
  _imagesSlider(BuildContext context) {
    return Obx(() => Container(
      height: AppStyle.getDeviceHeightPercent(25, context),
      width: AppStyle.getDeviceWidthPercent(100, context),
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider.builder(
                carouselController: homeController.carouselController,
                options: CarouselOptions(
                    height: AppStyle.getDeviceHeightPercent(25, context),
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlayInterval: Duration(seconds: 2),
                    onPageChanged: (index, reason) {
                      homeController.set_index(index);
                    }),
                itemCount: introController.banner.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration:BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(introController.banner[index].image!),
                          fit: BoxFit.fill,
                        )),
                  );
                },
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.25,
                  bottom: 10,
                  child: Container(
                    width: AppStyle.getDeviceWidthPercent(50, context),
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        duration: Duration(milliseconds: 500),
                        activeIndex: homeController.activeIndex.value,
                        count: introController.banner.length,
                        effect: SlideEffect(
                            dotWidth: 8,
                            dotHeight: 8,
                            activeDotColor: Colors.white,
                            dotColor: AppStyle.grey.withOpacity(0.5)
                        ),
                      ),
                    ),
                  )
              )
            ],
          ),
        ],
      ),
    ));
  }
  _servicesList(BuildContext context,IntroController introController,int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CustomGridViewServices(
        count: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        padding: 4,
        introController: introController,
      ),
    );
  }
  _brands(BuildContext context,IntroController introController) {
    return CustomListViewBrands(
      introController: introController,
    );
  }
  _blogsAndEventsList(BuildContext context) {
    return CustomListViewContainer(
      myList: introController.events,
      width: AppStyle.getDeviceWidthPercent(90, context),
      introController: introController,
    );
  }

}