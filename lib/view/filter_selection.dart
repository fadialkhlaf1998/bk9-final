import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/filter_selection_controler.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/view/product_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FilterSelection extends StatelessWidget {
  IntroController introController = Get.find();
  FilterSelectionControler filterSelectionControler = Get.put(FilterSelectionControler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return SafeArea(
          child: Stack(
            children: [
              Container(height: MediaQuery.of(context).size.height,),
              SingleChildScrollView(

                // physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ///header
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Center(
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              ///category
                              SizedBox(height: 20,),
                              GestureDetector(
                                onTap: (){
                                  filterSelectionControler.categoryOpen.value =
                                      !filterSelectionControler.categoryOpen.value;
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*0.9,
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
                                        Text("Categories",style: TextStyle(color: Colors.black,fontSize: 16),),
                                        Icon(filterSelectionControler.categoryOpen.value?Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              filterSelectionControler.categoryOpen.value
                                  ?categoriesList(context)
                                  :Center(),

                              ///brands
                              SizedBox(height: 20,),
                              GestureDetector(
                                onTap: (){
                                  filterSelectionControler.brandOpen.value =
                                  !filterSelectionControler.brandOpen.value;
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*0.9,
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
                                        Text("Brands",style: TextStyle(color: Colors.black,fontSize: 16),),
                                        Icon(filterSelectionControler.brandOpen.value?Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              filterSelectionControler.brandOpen.value
                                  ?brandList(context)
                                  :Center(),

                              ///best sellers
                              SizedBox(height: 20,),
                              GestureDetector(
                                onTap: (){
                                  Get.off(ProductFilter(introController.bestSellers));
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*0.9,
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
                                        Text("Best Sellers",style: TextStyle(color: Colors.black,fontSize: 16),),
                                        Icon(Icons.keyboard_arrow_right_outlined)
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              ///recomended
                              SizedBox(height: 20,),
                              GestureDetector(
                                onTap: (){
                                  Get.off(ProductFilter(introController.recomended));
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*0.9,
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
                                        Text("Recommended",style: TextStyle(color: Colors.black,fontSize: 16),),
                                        Icon(Icons.keyboard_arrow_right_outlined)
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              ///new Arrivals
                              SizedBox(height: 20,),
                              GestureDetector(
                                onTap: (){
                                  Get.off(ProductFilter(introController.newArrivals));
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*0.9,
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
                                        Text("New Arrivals",style: TextStyle(color: Colors.black,fontSize: 16),),
                                        Icon(Icons.keyboard_arrow_right_outlined)
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
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("assets/icons/logo.svg",width: 60,),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Text("Cancel",style: TextStyle(color: AppStyle.primary,fontSize: 14),),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(bottom: 0,
                child:   Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          filterSelectionControler.clear();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)
                          ),
                          child: Center(
                            child: Text("Clear"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          filterSelectionControler.apply(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // border: Border.all(color: Colors.grey),
                            color: AppStyle.primary
                          ),
                          child: Center(
                            child: filterSelectionControler.loading.value?Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircularProgressIndicator(color: Colors.white,),
                            ): Text("Apply",style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),)
            ],

          ),

        );
      }),
    );
  }

  categoriesList(BuildContext context){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: introController.superCategory.length+1,
      itemBuilder: (context,index){
        return index==0?
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  filterSelectionControler.selected_super_category.value= -1;
                },
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("All Categories"),
                      Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15 ),
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)
                          ),
                          child: -1 == filterSelectionControler.selected_super_category.value ? Center(
                            child: Icon(Icons.check ,color: AppStyle.primary,size: 18,),
                          ):Center(),
                        ),
                      ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            :Column(
              children: [
                Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  GestureDetector(
                    onTap: (){
                      if( introController.superCategory[index-1].id == filterSelectionControler.selected_super_category.value){
                        filterSelectionControler.selected_super_category.value = -1;
                      }else{
                        filterSelectionControler.selected_super_category.value = introController.superCategory[index - 1].id;
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width*0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //todo
                          Row(
                            children: [
                             Obx((){
                               return  GestureDetector(
                                 onTap: (){
                                   /// press dogs filter
                                   if( introController.superCategory[index-1].id == filterSelectionControler.selected_super_category.value){
                                     filterSelectionControler.selected_super_category.value = -1;
                                   }else{
                                     filterSelectionControler.selected_super_category.value = introController.superCategory[index - 1].id;
                                   }
                                 },
                                 child: Container(
                                   width: 20,
                                   height: 20,
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     border: Border.all(color: Colors.black.withOpacity(0.5)),
                                     borderRadius: BorderRadius.circular(3)
                                   ),
                                   child: Center(
                                       child: introController.superCategory[index-1].id == filterSelectionControler.selected_super_category.value
                                           ? Icon(Icons.remove, size: 18,)
                                           : Icon(Icons.add, size: 18,)
                                   ),
                                 ),
                               );
                             }),
                              const SizedBox(width: 5),
                              Text(introController.superCategory[index-1].title!),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
          ),
        ),
                Obx(() => introController.superCategory[index-1].id == filterSelectionControler.selected_super_category.value
                    ? catList(context, index-1)
                    : const Center()
                )
              ],
            );
      },
    );
  }
  catList(BuildContext context,int super_index){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filterSelectionControler.selected_super_category.value==-1?0:introController.superCategory[super_index].posts!.length+1,
      itemBuilder: (context,index){
        return index==0?
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  filterSelectionControler.selected_category.value= -1;

                },
                child: Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("All "+ introController.superCategory[super_index].title!),
                      Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15 ),
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)
                          ),
                          child: -1 == filterSelectionControler.selected_category.value ? Center(
                            child: Icon(Icons.check ,color: AppStyle.primary,size: 18,),
                          ):Center(),
                        ),
                      ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            :Column(
              children: [
                Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //todo
                  GestureDetector(
                    onTap: (){
                      if(filterSelectionControler.selected_category.value == introController.superCategory[super_index].posts![index-1].id){
                        filterSelectionControler.selected_category.value = -1;
                      }else{
                        filterSelectionControler.selected_category.value=
                            introController.superCategory[super_index].posts![index-1].id;
                      }
                    },
                    child: Container(
                      // color: Colors.black,
                      width: MediaQuery.of(context).size.width*0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx((){
                                return GestureDetector(
                                  onTap: (){
                                    if(filterSelectionControler.selected_category.value == introController.superCategory[super_index].posts![index-1].id){
                                      filterSelectionControler.selected_category.value = -1;
                                    }else{
                                      filterSelectionControler.selected_category.value=
                                          introController.superCategory[super_index].posts![index-1].id;
                                    }
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Center(
                                        child: introController.superCategory[super_index].posts![index-1].id == filterSelectionControler.selected_category.value
                                            ? Icon(Icons.remove, size: 18,)
                                            : Icon(Icons.add, size: 18,)
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(width: 5),
                              Container(
                                width: MediaQuery.of(context).size.width*0.7-(50+30),
                                child: Text(introController.superCategory[super_index].posts![index-1].title!,style: TextStyle(overflow: TextOverflow.ellipsis)),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
          ),
        ),
                Obx(() => introController.superCategory[super_index].posts![index-1].id == filterSelectionControler.selected_category.value ?subCatList(context,super_index,index-1):Center())

              ],
            );
      },
    );
  }

  subCatList(BuildContext context,int super_index,int cat_index){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filterSelectionControler.selected_super_category.value==-1?0:introController.superCategory[super_index].posts![cat_index].posts!.length+1,
      itemBuilder: (context,index){
        return index==0?
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  filterSelectionControler.selected_sub_category.value= -1;
                },
                child: Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width*0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        width: MediaQuery.of(context).size.width*0.6-(25+30),
                        child: Text("All "+ introController.superCategory[super_index].posts![cat_index].title!,overflow: TextOverflow.ellipsis),
                      ),

                      Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15 ),
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)
                          ),
                          child: -1 == filterSelectionControler.selected_sub_category.value ? Center(
                            child: Icon(Icons.check ,color: AppStyle.primary,size: 18,),
                          ):Center(),
                        ),
                      ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            :Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  filterSelectionControler.selected_sub_category.value=
                      introController.superCategory[super_index].posts![cat_index].posts![index-1].id;
                },
                child: Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width*0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      Container(
                        width: MediaQuery.of(context).size.width*0.6-(25+30),
                        child: Text(introController.superCategory[super_index].posts![cat_index].posts![index-1].title!,style: TextStyle(overflow: TextOverflow.ellipsis)),
                      ),
                      Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15 ),
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)
                          ),
                          child:introController.superCategory[super_index].posts![cat_index].posts![index-1].id == filterSelectionControler.selected_sub_category.value ? Center(
                            child: Icon(Icons.check ,color: AppStyle.primary,size: 18,),
                          ):Center(),
                        ),
                      ),)
                    ],
                  ),
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
        return index==0?
            Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  filterSelectionControler.selected_brand_id.value= -1;
                },
                child: Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      Text("All Brands"),
                      Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15 ),
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)
                          ),
                          child: -1 == filterSelectionControler.selected_brand_id.value ? Center(
                            child: Icon(Icons.check ,color: AppStyle.primary,size: 18,),
                          ):Center(),
                        ),
                      ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            :Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  filterSelectionControler.selected_brand_id.value=
                      introController.brand[index-1].id;
                },
                child: Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                        Text(introController.brand[index-1].title!),
                        Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15 ),
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey)
                            ),
                            child:introController.brand[index-1].id == filterSelectionControler.selected_brand_id.value ? Center(
                              child: Icon(Icons.check ,color: AppStyle.primary,size: 18,),
                            ):Center(),
                          ),
                        ),)
                      ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
