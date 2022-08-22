import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/controller/product_filter_controller.dart';
import 'package:bk9/controller/shop_controller.dart';
import 'package:bk9/view/filter_selection.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class CustomFilterSort extends StatelessWidget {

  ShopController shopController;
  ProductFilterController? productFilterController;
  IntroController introController = Get.find();
  bool off;

  CustomFilterSort({
    required this.shopController,
    this.productFilterController,
    required this.off
});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(100, context),
      height: 110,
      color: AppStyle.primary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              if(this.off){
                Get.off(() => FilterSelection());
              }else{
                Get.to(() => FilterSelection());
              }

            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                color: Colors.transparent,
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/filter.svg",width: 25,height: 25,color: Colors.white,),
                    SizedBox(width: 20),
                    Text("Filter by",
                        style: CommonTextStyle.textStyleForOrangeMediumButton
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            child: const VerticalDivider(
              color: Colors.white,
              thickness: 1,
              indent: 30,
              endIndent: 5,
              width: 20,
            ),
          ),
          GestureDetector(
            onTap: () {
              sortBottomSheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                width: 150,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/sort.svg",width: 25,height: 25,color: Colors.white,),
                    SizedBox(width: 20),
                    Text("Sort by",
                        style: CommonTextStyle.textStyleForOrangeMediumButton
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  sortBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
          ),
      ),
      builder: (context) {
        return Container(
          height: AppStyle.getDeviceHeightPercent(20, context)+200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Obx((){
              return Column(
                children: [
                  Container(
                    width: AppStyle.getDeviceWidthPercent(78, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sort By",
                            style: TextStyle(
                                color: AppStyle.grey,
                                fontSize: CommonTextStyle.mediumTextStyle,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.close,color: AppStyle.grey,size: 23,),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: AppStyle.getDeviceWidthPercent(85, context),
                      height: AppStyle.getDeviceHeightPercent(5, context),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppStyle.greyButton,
                          onPrimary: AppStyle.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppStyle.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Center(
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: shopController.sort_state.value == 0?AppStyle.primary:Colors.white,
                                        border: Border.all(color: AppStyle.grey)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text("Newest First",
                              style: TextStyle(
                                  color: AppStyle.productGrey,
                                  fontSize: CommonTextStyle.smallTextStyle
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          shopController.sort_state.value =0;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: AppStyle.getDeviceWidthPercent(85, context),
                      height: AppStyle.getDeviceHeightPercent(5, context),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppStyle.greyButton,
                          onPrimary: AppStyle.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppStyle.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Center(
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: shopController.sort_state.value == 1?AppStyle.primary:Colors.white,
                                        border: Border.all(color: AppStyle.grey)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text("Top Rated",
                              style: TextStyle(
                                  color: AppStyle.productGrey,
                                  fontSize: CommonTextStyle.smallTextStyle
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          shopController.sort_state.value =1;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: AppStyle.getDeviceWidthPercent(85, context),
                      height: AppStyle.getDeviceHeightPercent(5, context),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppStyle.greyButton,
                          onPrimary: AppStyle.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppStyle.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Center(
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: shopController.sort_state.value == 2?AppStyle.primary:Colors.white,
                                        border: Border.all(color: AppStyle.grey)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text("Lowest Price",
                              style: TextStyle(
                                  color: AppStyle.productGrey,
                                  fontSize: CommonTextStyle.smallTextStyle
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          shopController.sort_state.value =2;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: AppStyle.getDeviceWidthPercent(85, context),
                      height: AppStyle.getDeviceHeightPercent(5, context),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppStyle.greyButton,
                          onPrimary: AppStyle.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppStyle.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Center(
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: shopController.sort_state.value == 3?AppStyle.primary:Colors.white,
                                        border: Border.all(color: AppStyle.grey)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text("Highest Price",
                              style: TextStyle(
                                  color: AppStyle.productGrey,
                                  fontSize: CommonTextStyle.smallTextStyle
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          shopController.sort_state.value =3;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(productFilterController!=null&&off==true){
                            productFilterController!.posts.value = shopController.sort(productFilterController!.posts.value);
                            Get.back();
                          }else{
                            shopController.loading.value = true;
                            shopController.productsView.value = shopController.sort(shopController.productsView.value);
                            shopController.loading.value = false;
                            Get.back();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppStyle.primary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text("Apply",
                              style: CommonTextStyle.textStyleForOrangeMediumButton
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            }),
          ),
        );
      },
    );
  }

}