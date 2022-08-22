import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/filter_selection_controler.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/view/product_filter.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FilterSelection extends StatelessWidget {

  IntroController introController = Get.find();
  FilterSelectionController filterSelectionController = Get.put(FilterSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return SafeArea(
          child: Stack(
            children: [
              Container(height: AppStyle.getDeviceHeightPercent(100, context)),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: AppStyle.getDeviceWidthPercent(100, context),
                    ),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(90, context),
                      child: Center(
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              ///categories
                              GestureDetector(
                                onTap: (){
                                  filterSelectionController.categoryOpen.value = !filterSelectionController.categoryOpen.value;
                                },
                                child: Container(
                                  height: 45,
                                  width: AppStyle.getDeviceWidthPercent(90, context),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        offset: Offset(0,1),
                                        blurRadius: 2,
                                        spreadRadius: 0.1
                                      )
                                    ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Categories",
                                          style: TextStyle(
                                              color: AppStyle.darkGrey,
                                              fontSize: CommonTextStyle.mediumTextStyle,
                                          ),),
                                        Icon(Icons.add, size: 23, color: AppStyle.primary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              filterSelectionController.categoryOpen.value ?
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  categoriesList(context),
                                ],
                              ) : Center(),
                              SizedBox(height: 15,),
                              ///brands
                              GestureDetector(
                                onTap: (){
                                  filterSelectionController.brandOpen.value = !filterSelectionController.brandOpen.value;
                                },
                                child: Container(
                                  height: 45,
                                  width: AppStyle.getDeviceWidthPercent(90, context),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(0,1),
                                            blurRadius: 2,
                                            spreadRadius: 0.1
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Brands",
                                          style: TextStyle(
                                            color: AppStyle.darkGrey,
                                            fontSize: CommonTextStyle.mediumTextStyle,
                                          ),),
                                        Icon(Icons.add, size: 23, color: AppStyle.primary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              filterSelectionController.brandOpen.value ?
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  brandList(context)
                                ],
                              ) : Center(),
                              SizedBox(height: 15),
                              ///best sellers
                              GestureDetector(
                                onTap: (){
                                  Get.off(() => ProductFilter(introController.bestSellers));
                                },
                                child: Container(
                                  height: 45,
                                  width: AppStyle.getDeviceWidthPercent(90, context),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(0,1),
                                            blurRadius: 2,
                                            spreadRadius: 0.1
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Best Sellers",
                                          style: TextStyle(
                                            color: AppStyle.darkGrey,
                                            fontSize: CommonTextStyle.mediumTextStyle,
                                          ),),
                                        Icon(Icons.keyboard_arrow_right_outlined, size: 23, color: AppStyle.primary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              ///recommended
                              GestureDetector(
                                onTap: (){
                                  Get.off(() => ProductFilter(introController.recommended));
                                },
                                child: Container(
                                  height: 45,
                                  width: AppStyle.getDeviceWidthPercent(90, context),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(0,1),
                                            blurRadius: 2,
                                            spreadRadius: 0.1
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Recommended",
                                          style: TextStyle(
                                            color: AppStyle.darkGrey,
                                            fontSize: CommonTextStyle.mediumTextStyle,
                                          ),),
                                        Icon(Icons.keyboard_arrow_right_outlined, size: 23, color: AppStyle.primary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              ///new Arrivals
                              GestureDetector(
                                onTap: (){
                                  Get.off(() => ProductFilter(introController.newArrivals));
                                },
                                child: Container(
                                  height: 45,
                                  width: AppStyle.getDeviceWidthPercent(90, context),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(0,1),
                                            blurRadius: 2,
                                            spreadRadius: 0.1
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("New Arrivals",
                                          style: TextStyle(
                                            color: AppStyle.darkGrey,
                                            fontSize: CommonTextStyle.mediumTextStyle,
                                          ),),
                                        Icon(Icons.keyboard_arrow_right_outlined, size: 23, color: AppStyle.primary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              ///offers
                              GestureDetector(
                                onTap: (){
                                  Get.off(() => ProductFilter(introController.offers));
                                },
                                child: Container(
                                  height: 45,
                                  width: AppStyle.getDeviceWidthPercent(90, context),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(0,1),
                                            blurRadius: 2,
                                            spreadRadius: 0.1
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Offers",
                                          style: TextStyle(
                                            color: AppStyle.darkGrey,
                                            fontSize: CommonTextStyle.mediumTextStyle,
                                          ),),
                                        Icon(Icons.keyboard_arrow_right_outlined, size: 23, color: AppStyle.primary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: AppStyle.getDeviceWidthPercent(100, context),
                    ),
                  ],
                ),
              ),
              header(context),
              Positioned(
                  bottom: 0,
                  child: clearFilterButtons(context)
              )
            ],
          ),
        );
      }),
    );
  }

  header(BuildContext context){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
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
            Text("Filter By",
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
        )
    );
  }
  categoriesList(BuildContext context){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: introController.superCategory.length + 1,
      itemBuilder: (context,index) {
        return index == 0 ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text("All Categories",
                style: CommonTextStyle.textStyleForGreySmallButton,
              ),
            ),
            Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey)
                ),
                child: -1 == filterSelectionController.selected_super_category.value ? Center(
                  child: Icon(Icons.check ,color: AppStyle.primary,size: 15,),
                ) : Center(),
              ),
            ),)
          ],
        ) :
        Column(
          children: [
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 35),
            child: GestureDetector(
              onTap: (){
                if(introController.superCategory[index-1].id == filterSelectionController.selected_super_category.value){
                  filterSelectionController.selected_super_category.value = -1;
                }else{
                  filterSelectionController.selected_super_category.value = introController.superCategory[index - 1].id;
                }
              },
              child: Row(
                children: [
                  Obx(() => GestureDetector(
                      onTap: (){
                        /// press dogs filter
                        if( introController.superCategory[index-1].id == filterSelectionController.selected_super_category.value){
                          filterSelectionController.selected_super_category.value = -1;
                        }else{
                          filterSelectionController.selected_super_category.value = introController.superCategory[index - 1].id;
                        }
                      },
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                            child: introController.superCategory[index-1].id == filterSelectionController.selected_super_category.value
                                ? Icon(Icons.remove, size: 15,)
                                : Icon(Icons.add, size: 15,)
                        ),
                      ),
                    )),
                  const SizedBox(width: 5),
                  Text(introController.superCategory[index-1].title!,
                    style: TextStyle(
                        fontSize: CommonTextStyle.smallTextStyle,
                        color: AppStyle.darkGrey,
                        fontWeight: FontWeight.normal
                    )
                  ),
                ],
              ),
            ),
            ),
            Obx(() => introController.superCategory[index-1].id == filterSelectionController.selected_super_category.value
                ? categoryList(context, index-1)
                : const Center()
            )
          ],
        );
      },
    );
  }
  categoryList(BuildContext context,int super_index){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filterSelectionController.selected_super_category.value==-1?0:introController.superCategory[super_index].posts!.length+1,
      itemBuilder: (context,index){
        return index == 0 ?
        GestureDetector(
          onTap: (){
            filterSelectionController.selected_category.value= -1;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 50),
               child:  Text("All "+ introController.superCategory[super_index].title!,
                 style: CommonTextStyle.textStyleForGreySmallButton,
               ),
             ),
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15 ),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey)
                  ),
                  child: -1 == filterSelectionController.selected_category.value ? Center(
                    child: Icon(Icons.check ,color: AppStyle.primary,size: 15,),
                  ) : Center(),
                ),
              ),
              )
            ],
          ),
        ) :
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 60),
              child: GestureDetector(
                onTap: (){
                  if(filterSelectionController.selected_category.value == introController.superCategory[super_index].posts![index-1].id){
                    filterSelectionController.selected_category.value = -1;
                  }else{
                    filterSelectionController.selected_category.value=
                        introController.superCategory[super_index].posts![index-1].id;
                  }
                },
                child: Row(
                  children: [
                    Obx((){
                      return GestureDetector(
                        onTap: (){
                          if(filterSelectionController.selected_category.value == introController.superCategory[super_index].posts![index-1].id){
                            filterSelectionController.selected_category.value = -1;
                          }else{
                            filterSelectionController.selected_category.value=
                                introController.superCategory[super_index].posts![index-1].id;
                          }
                        },
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Center(
                              child: introController.superCategory[super_index].posts![index-1].id == filterSelectionController.selected_category.value
                                  ? Icon(Icons.remove, size: 15,)
                                  : Icon(Icons.add, size: 15)
                          ),
                        ),
                      );
                    }),
                    SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(introController.superCategory[super_index].posts![index-1].title!,
                          style: TextStyle(
                              fontSize: CommonTextStyle.smallTextStyle,
                              color: AppStyle.darkGrey,
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis)),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => introController.superCategory[super_index].posts![index-1].id == filterSelectionController.selected_category.value ?
             subCatList(context,super_index,index-1) : Center()
            )
          ],
        );
      },
    );
  }
  subCatList(BuildContext context,int super_index,int cat_index){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filterSelectionController.selected_super_category.value==-1?0:introController.superCategory[super_index].posts![cat_index].posts!.length+1,
      itemBuilder: (context,index){
        return index == 0 ?
        GestureDetector(
          onTap: (){
            filterSelectionController.selected_sub_category.value= -1;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: AppStyle.getDeviceWidthPercent(58, context),
                child: Text(introController.superCategory[super_index].posts![cat_index].title!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: CommonTextStyle.smallTextStyle,
                    color: AppStyle.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15 ),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey)
                  ),
                  child: -1 == filterSelectionController.selected_sub_category.value ? Center(
                    child: Icon(Icons.check ,color: AppStyle.primary,size: 15,),
                  ):Center(),
                ),
              ),)
            ],
          ),
        ) :
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  filterSelectionController.selected_sub_category.value= introController.superCategory[super_index].posts![cat_index].posts![index-1].id;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: AppStyle.getDeviceWidthPercent(58, context),
                      child: Text(introController.superCategory[super_index].posts![cat_index].posts![index-1].title!,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                            fontSize: CommonTextStyle.smallTextStyle,
                            color: AppStyle.grey,
                            fontWeight: FontWeight.normal,

                          )),
                    ),
                    Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15 ),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)
                        ),
                        child:introController.superCategory[super_index].posts![cat_index].posts![index-1].id == filterSelectionController.selected_sub_category.value ? Center(
                          child: Icon(Icons.check ,color: AppStyle.primary,size: 15,),
                        ) : Center(),
                      ),
                    ),)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  brandList(BuildContext context){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: introController.brand.length+1,
      itemBuilder: (context,index){
        return index == 0 ?
        GestureDetector(
          onTap: (){
            filterSelectionController.selected_brand_id.value= -1;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text("All Brands",
                  style: CommonTextStyle.textStyleForGreySmallButton,
                ),
              ),
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15 ),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey)
                  ),
                  child: -1 == filterSelectionController.selected_brand_id.value ? Center(
                    child: Icon(Icons.check ,color: AppStyle.primary,size: 15,),
                  ):Center(),
                ),
              ),)
            ],
          ),
        ) :
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: GestureDetector(
            onTap: (){
              filterSelectionController.selected_brand_id.value= introController.brand[index-1].id;
            },
            child: Container(
              // color: Colors.black,
              width: MediaQuery.of(context).size.width*0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Text(introController.brand[index-1].title!,
                      style: CommonTextStyle.textStyleForDarkGreySmallButtonNormal,
                    ),
                  ),
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15 ),
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey)
                      ),
                      child:introController.brand[index-1].id == filterSelectionController.selected_brand_id.value ? Center(
                        child: Icon(Icons.check ,color: AppStyle.primary,size: 15,),
                      ):Center(),
                    ),
                  ),)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  clearFilterButtons(BuildContext context) {
    return Container(
      height: 70,
      width: AppStyle.getDeviceWidthPercent(100, context),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: Offset(1,1)
            )
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
                text: "Clear",
                onPressed: () {
                  filterSelectionController.clear();
                },
                color: AppStyle.greyButton,
                borderRadius: 30,
                border: Colors.transparent,
                width: AppStyle.getDeviceWidthPercent(35, context),
                height: AppStyle.getDeviceHeightPercent(5, context),
                textStyle: CommonTextStyle.textStyleForDarkGreyMediumButton
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Center(
                child: Container(
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  width: AppStyle.getDeviceWidthPercent(35, context),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppStyle.primary,
                      onPrimary: AppStyle.primary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: FittedBox(
                      child: filterSelectionController.loading.value ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: CircularProgressIndicator(color: Colors.white,),
                      ) :
                      Text("Apply",
                          style: CommonTextStyle.textStyleForOrangeMediumButtonBold  // this.textStyle,
                      ),
                    ),
                    onPressed: () {
                      filterSelectionController.apply(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
