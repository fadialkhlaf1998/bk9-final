import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class CreateAddress extends StatelessWidget {

  int id;
  CreateAddress(this.id,int selectEdit,String nickName,int defaultAddress,String adrs1,String adrs2,String apartment,String phone,String country,String emirate) {
    if(selectEdit == 0) {
      addressController.selectEdit.value = selectEdit;
      addressController.clear();
    } else{
      addressController.nickName.text = nickName;
      addressController.defaultAddress.value = defaultAddress;
      addressController.adddress1.text = adrs1;
      addressController.adddress2.text = adrs2;
      addressController.apartment.text = apartment;
      addressController.phone.text = phone;
      addressController.country.value = country;
      addressController.emirate.value = emirate;
    }
  }

  AddressesController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(()=> SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100,),
                    _add_address(context),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: _header(context),
              )
            ],
          ),
        ))
    );
  }

  _header(BuildContext context) {
    return Container(
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
            child: Text(
              addressController.selectEdit.value == 0 ?
                "create address" : "edit address",
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
  _add_address(BuildContext context) {
    return Column(
      children: [
        normalTextField(80,6.5,"NickName",addressController.nickName,addressController.nickNameValidate.value,context),
        SizedBox(height: 20),
        normalTextField(80,6.5,"Address 1",addressController.adddress1,addressController.address1Validate.value,context),
        SizedBox(height: 20),
        normalTextField(80,6.5,"Address 2",addressController.adddress2,addressController.address2Validate.value,context),
        SizedBox(height: 20),
        Container(
            width: AppStyle.getDeviceWidthPercent(80, context),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: !addressController.countryValidate.value && addressController.country.value=="non"?Colors.red:AppStyle.grey.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                isExpanded: true,
                hint: Text("Country",
                  style: TextStyle(
                      color: AppStyle.grey,
                      fontSize: CommonTextStyle.mediumTextStyle,
                      fontWeight: FontWeight.normal
                  ),
                ),
                iconEnabledColor: AppStyle.grey,
                value: addressController.country.value=="non"? null : addressController.country.value,
                items: addressController.countries.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: TextStyle(
                            color: AppStyle.darkGrey,
                            fontSize: CommonTextStyle.smallTextStyle,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  );
                }).toList(),
                underline: Container(),
                onChanged: (val) {
                  addressController.country.value=val.toString();
                },
              ),
            )
        ),
        SizedBox(height: 20),
        Container(
            width: AppStyle.getDeviceWidthPercent(80, context),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: !addressController.emirateValidate.value && addressController.emirate.value=="non"?Colors.red:AppStyle.grey.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                isExpanded: true,
                hint: Text( "Emirate",
                  style: TextStyle(
                      color: AppStyle.grey,
                      fontSize: CommonTextStyle.mediumTextStyle,
                      fontWeight: FontWeight.normal
                  ),
                ),
                iconEnabledColor: AppStyle.grey,
                value: addressController.emirate.value=="non"? null : addressController.emirate.value,
                items: addressController.emirates.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: TextStyle(
                            color: AppStyle.darkGrey,
                            fontSize: CommonTextStyle.smallTextStyle,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  );
                }).toList(),
                underline: Container(),
                onChanged: (val) {
                  addressController.emirate.value=val.toString();
                },
              ),
            )
        ),
        SizedBox(height: 20),
        normalTextField(80,6.5,"Apartment",addressController.apartment,addressController.apartmentValidate.value,context),
        SizedBox(height: 20),
        Container(
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context)+20,
            child: Stack(
              children: [
                TextField(
                  controller: addressController.phone,
                  cursorColor: AppStyle.darkGrey,
                  style: TextStyle(color: AppStyle.darkGrey,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Phone",
                    prefix: Text("+971 "),
                    prefixStyle: TextStyle(
                        color: AppStyle.darkGrey,
                        fontSize: CommonTextStyle.mediumTextStyle,
                        fontWeight: FontWeight.normal
                    ),
                    labelStyle: TextStyle(
                        color: AppStyle.grey,
                        fontSize: CommonTextStyle.mediumTextStyle,
                        fontWeight: FontWeight.normal
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: addressController.phoneValidate.value ? AppStyle.grey.withOpacity(0.5) : Colors.red),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: addressController.phoneValidate.value? AppStyle.primary : Colors.red),
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
              ],
            )
        ),
        SizedBox(height: 20),
        Container(
          width: AppStyle.getDeviceWidthPercent(75, context),
          child: Row(
            children: [
              Obx(() => GestureDetector(
                  onTap: () {
                    addressController.defaultValidate.value = !addressController.defaultValidate.value;
                    if(addressController.defaultValidate.value) {
                      addressController.defaultAddress.value = 1;
                    } else {
                      addressController.defaultAddress.value = 0;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(addressController.defaultValidate.value ?
                    Icons.check_box : Icons.check_box_outline_blank,color: AppStyle.primary),
                  )
              )),
              SizedBox(width: 5,),
              Text("Default Address",
                style: TextStyle(
                    color: AppStyle.grey,
                    fontSize: CommonTextStyle.mediumTextStyle,
                    fontWeight: FontWeight.normal
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        _createEditBotton(context),
        SizedBox(height: 20),
      ],
    );
  }
  normalTextField(double width,double height,String text,TextEditingController controller,bool validate,BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width * (width / 100),
      height: MediaQuery.of(context).size.height * (height / 100),
      child: TextField(
        controller: controller,
        cursorColor: AppStyle.darkGrey,
        style: TextStyle(color: AppStyle.darkGrey,fontWeight: FontWeight.bold,fontSize: CommonTextStyle.smallTextStyle),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: text,
          labelStyle: TextStyle(
              color: AppStyle.grey,
              fontSize: CommonTextStyle.mediumTextStyle,
              fontWeight: FontWeight.normal
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: validate ? AppStyle.grey.withOpacity(0.5) : Colors.red),
              borderRadius: BorderRadius.circular(30)
          ),
          focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: validate? AppStyle.primary : Colors.red),
              borderRadius: BorderRadius.circular(30)
          ),
        ),
      ),
    );
  }
  _createEditBotton(BuildContext context) {
    return CustomButton(
        text: addressController.selectEdit.value == 0 ? "Create" : "Edit",
        onPressed: () {
          if(addressController.selectEdit.value == 0) {
            addressController.addAddress(context,
              addressController.nickName.text,
              addressController.defaultAddress.value,
              addressController.adddress1.text,
              addressController.adddress2.text,
              addressController.apartment.text,
              addressController.phone.text,
              addressController.emirate.value,
              addressController.country.value,
            );
          }else {
            addressController.editAddress(context,
              addressController.nickName.text,
              addressController.defaultAddress.value,
              addressController.adddress1.text,
              addressController.adddress2.text,
              addressController.apartment.text,
              addressController.phone.text,
              addressController.emirate.value,
              addressController.country.value,
              id
            );
          }

        },
        color: AppStyle.primary,
        borderRadius: 30,
        border: AppStyle.primary,
        width: AppStyle.getDeviceWidthPercent(80, context),
        height: AppStyle.getDeviceHeightPercent(6.5, context),
        textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
    );
  }
}
