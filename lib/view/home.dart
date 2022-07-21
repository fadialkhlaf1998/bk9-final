import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/home_controller.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/custom_gridView_services.dart';
import 'package:bk9/widgets/search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _header(context),
                SizedBox(height: 20),
                _imagesSlider(context),
                SizedBox(height: 20),
                CustomButton(
                    text: "Login / Sign Up",
                    onPressed: () {
                      Get.back();
                    },
                    color: AppStyle.primary,
                    borderRadius: 30,
                    border: Colors.transparent,
                    width: AppStyle.getDeviceWidthPercent(80, context),
                    height: AppStyle.getDeviceHeightPercent(7, context),
                    textStyle: CommonTextStyle.textStyleForOrangeBigButton
                ),
                SizedBox(height: 20),
                Container(
                  width: AppStyle.getDeviceWidthPercent(90, context),
                  child: Text("Services",
                    style: CommonTextStyle.textStyleForDarkGreyXLargeButton
                  ),
                ),
                _servicesList(context),
              ],
            ),
          )
        ],
      )
    );
  }

  _header(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(100, context),
      height: AppStyle.getDeviceHeightPercent(28, context),
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
          SizedBox(height: 15,),
          Container(
            width: AppStyle.getDeviceWidthPercent(95, context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ContainerWithImage(
                        width: 90,
                        height: 90,
                        image: "assets/icons/logo.svg",
                        option: 0),
                    Container(
                      height: 80,
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
                        Text("The",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18
                          ),
                        ),
                        Text("BARKLEY",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                        SizedBox(height: 6)
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      ///
                    },
                    child: ContainerWithImage(
                        width: 50,
                        height: 100,
                        image: "assets/icons/wishlist.svg",
                        color: AppStyle.grey,
                        option: 0)
                )
              ],
            ),
          ),
          SizedBox(height: 15,),
          Search(width: AppStyle.getDeviceWidthPercent(90, context)),
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
                itemCount: homeController.carouselSliderImages.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration:BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(homeController.carouselSliderImages[index]),
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
                        count: homeController.carouselSliderImages.length,
                        effect: SlideEffect(
                          dotWidth: 10,
                          dotHeight: 10,
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
  _servicesList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomGridViewServices(
        count: 3,
        childAspectRatio: 1,
        myList: homeController.service,
        onTap: () {
          // services page
        },
      ),
    );
  }
  _offers(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(90, context),
      height: AppStyle.getDeviceHeightPercent(10, context),

    );
  }
}
