import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrands extends StatelessWidget {

  AllBrands() {}
  IntroController introController = Get.find();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 80,),
                    _brandsList(context),
                    SizedBox(height: 20),
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
              _header(context),
            ],
          ),
        ))
    );
  }

  _header(BuildContext context) {
    return  Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: AppStyle.getDeviceWidthPercent(100, context),
        height: 70,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back,size: 23,)
                ),
                SizedBox(width: 25),
                Text("All Brands",
                    style: CommonTextStyle.textStyleForDarkGreyMediumButton
                ),
              ],
            ),
            Container()
          ],
        )
    );
  }
  _brandsList(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.3
          ),
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: introController.brand.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap:  (){
                  introController.shopByBrand(context,introController.brand[index].id,introController.brand[index].title.toString());
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Container(
                        width: AppStyle.getDeviceWidthPercent(21, context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),

                        ),
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.all(17),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(introController.brand[index].image!),
                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                        )
                    ),
                  ),
                )
            );
          })
    );
  }

}