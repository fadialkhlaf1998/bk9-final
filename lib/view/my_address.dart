import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/account_controller.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/view/create_address.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAddress extends StatelessWidget {

  AddressesController addressesController = Get.find();
  AccountController accountController = Get.find();
  // RxBool loading = false.obs;

  MyAddress() {
    API.checkInternet().then((internet) {
      if(internet) {
        addressesController.loading.value = true;
        API.getAddress().then((value) {
          if(value.isNotEmpty) {
            addressesController.addresses.clear();
            addressesController.addresses.addAll(value);
            addressesController.loading.value = false;
            // Get.to(() => MyAddress());
            addressesController.clear();
          }else{
            addressesController.loading.value = false;
          }
        });
      }else {
        Get.to(() => NoInternet())!.then((value) {
          Get.off(()=> MyAddress());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppStyle.primary,
          onPressed: () {
            Get.to(() => CreateAddress(
              -1,
              0,
              addressesController.nickName.text,
              addressesController.defaultAddress.value,
              addressesController.adddress1.text,
              addressesController.adddress2.text,
              addressesController.apartment.text,
              addressesController.phone.text,
              addressesController.emirate.value,
              addressesController.country.value,
            ));
          },
          child: const Icon(Icons.add,color: Colors.white),
        ),
        body: Obx(() => SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              addressesController.loading.value?
              Positioned(
                child: Column(
                  children: [
                    _header(context),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      color: Colors.white.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(color: AppStyle.primary,),
                      ),
                    )
                  ],
                ),
              ) :
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _header(context),
                    SizedBox(height: 30),
                    _body(context),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        ))
    );
  }

  _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: AppStyle.getDeviceWidthPercent(100, context),
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
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back,size: 23,)
          ),
          SizedBox(width: 25),
          Container(
            width: AppStyle.getDeviceWidthPercent(45, context),
            child: Text("My Addresses",
                style: TextStyle(
                  fontSize: CommonTextStyle.mediumTextStyle,
                  color: AppStyle.darkGrey,
                  fontWeight: FontWeight.bold,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: GestureDetector(
                onTap: () {
                  ///wishlist page
                },
                child: ContainerWithImage(
                    width: 40,
                    height: 70,
                    image: "assets/icons/wishlist.svg",
                    color: Colors.transparent,
                    option: 0)
            ),
          )
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        addressesController.addresses.isEmpty?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("Dear ",
                   style: CommonTextStyle.textStyleForDarkGreyMediumButton
               ),
               Text(API.customer!.firstname,
                   style: CommonTextStyle.textStyleForWhiteSmallButton
               ),
             ],
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("no address to you,",
                    style: CommonTextStyle.textStyleForWhiteSmallButton
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("if you want create new address",
                    style: CommonTextStyle.textStyleForWhiteSmallButton
                ),
              ],
            ),
          ],
        ) :
        _addressesList(context),
        SizedBox(height: 50),
      ],
    );
  }
  _addressesList(BuildContext context) {
    return Container(
      width: AppStyle.getDeviceWidthPercent(90, context),
      height: AppStyle.getDeviceHeightPercent(60, context),
      child:  ListView.builder(
        itemCount: addressesController.addresses.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return Container(
              width: AppStyle.getDeviceWidthPercent(85, context),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color:  Colors.grey.withOpacity(0.3),
                    blurRadius: 2,
                    spreadRadius: 1,
                    offset: Offset(1,3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(addressesController.addresses[index].firstName.toUpperCase(),
                          style: CommonTextStyle.textStyleForWhiteMediumButton,
                        ),
                        CustomButton(
                            text: "Default Address",
                            onPressed: () {
                              if(addressesController.addresses[index].isDefault == 1) {
                                print(addressesController.addresses[index].isDefault);
                              }
                              else {
                                addressesController.setDefault(addressesController.addresses[index]);
                              }
                            },
                            color: addressesController.addresses[index].isDefault == 1 ?
                            AppStyle.primary : Colors.grey.withOpacity(0.5),
                            borderRadius: 30,
                            border: addressesController.addresses[index].isDefault == 1 ?
                            AppStyle.primary : Colors.grey.withOpacity(0.5),
                            width: 100,
                            height: 30,
                            textStyle: CommonTextStyle.textStyleForOrangeBigButton
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(addressesController.addresses[index].address1,
                          style: CommonTextStyle.textStyleForDarkGreyMediumButton,
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(addressesController.addresses[index].address2,
                          style: CommonTextStyle.textStyleForDarkGreyMediumButton,
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(addressesController.addresses[index].country,
                          style: CommonTextStyle.textStyleForGreySmallButton,
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: AppStyle.getDeviceWidthPercent(70, context),
                      child: Row(
                        children: [
                          Text(addressesController.addresses[index].apartment + "  " + addressesController.addresses[index].state,
                            style: CommonTextStyle.textStyleForGreySmallButton,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(addressesController.addresses[index].phone,
                          style: CommonTextStyle.textStyleForGreySmallButton,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  addressesController.selectEdit.value = 1;
                                  Get.to(() => CreateAddress(
                                    addressesController.addresses[index].id,
                                    1,
                                    addressesController.addresses[index].firstName,
                                    addressesController.addresses[index].isDefault,
                                    addressesController.addresses[index].address1,
                                    addressesController.addresses[index].address2,
                                    addressesController.addresses[index].apartment,
                                    addressesController.addresses[index].phone,
                                    addressesController.addresses[index].country,
                                    addressesController.addresses[index].state,
                                  ));
                                },
                                child: Icon(Icons.edit,color: AppStyle.primary)),
                            SizedBox(width: 10,),
                            GestureDetector(
                                onTap: () {
                                  addressesController.deleteAddress(context, addressesController.addresses[index]);
                                },
                                child: Icon(Icons.delete,color: Colors.red,))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }


}