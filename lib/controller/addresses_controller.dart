import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/model/address.dart';
import 'package:bk9/view/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressesController extends GetxController {

  Address? address;
  var loading = false.obs;
  RxList<Address> addresses = <Address>[].obs;
  TextEditingController adddress1 = TextEditingController();
  TextEditingController adddress2 = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController nickName = TextEditingController();
  var address1Validate = true.obs;
  var address2Validate = true.obs;
  var apartmentValidate = true.obs;
  var nickNameValidate = true.obs;
  RxList<String> emirates = ["abu dhabi","ajman","dubai","fujairah","ras al Khaimah","sharjah","umm al Quwain"].obs;
  RxList<String> countries = ["United Arab Emirates"].obs;
  Rx<String> emirate="non".obs;
  Rx<String> country ="non".obs;
  var emirateValidate = true.obs;
  var countryValidate = true.obs;
  var phoneValidate = true.obs;
  var defaultAddress = 0.obs;
  var defaultValidate = false.obs;
  var selectEdit = 0.obs;

  addAddress(BuildContext context,String nickName,int defaultAddress,String adrs1,String adrs2,String apartment,String phone,String country,String emirate) {
    if(adrs1.isEmpty || adrs2.isEmpty || phone.isEmpty || apartment.isEmpty || emirate == "non" || country == "non" || phone.length < 9){
      if(nickName.isEmpty){
        nickNameValidate.value=false;
      }else{
        nickNameValidate.value=true;
      }
      if(adrs1.isEmpty){
        address1Validate.value=false;
      }else{
        address1Validate.value=true;
      }
      if(adrs2.isEmpty){
        address2Validate.value=false;
      }else{
        address2Validate.value=true;
      }
      if(phone.isEmpty || phone.length < 9){
        AppStyle.errorMsg(context,"Phone number is wrong");
        phoneValidate.value=false;
      }else{
        phoneValidate.value=true;
      }
      if(apartment.isEmpty){
        apartmentValidate.value=false;
      }else{
        apartmentValidate.value=true;
      }
      if(emirate == "non"){
        emirateValidate.value=false;
      }else{
        emirateValidate.value=true;
      }
      if(country == "non"){
        countryValidate.value=false;
      }else{
        countryValidate.value=true;
      }
    }
    else {
      loading.value = true;
      API.checkInternet().then((internet) {
        if(internet) {
          API.addAddress(nickName,defaultAddress,adrs1,adrs2,apartment,phone,emirate,country).then((value) {
          }).then((value) {
            AppStyle.successMsg(context,"address saved successfully");
            Get.back();
            loading.value = false;
            getAddress();
          });
        }else{
          Get.to(() => NoInternet())!.then((value) {
            addAddress(context,nickName,defaultAddress,adrs1,adrs2,phone,apartment,emirate,country);
          });
        }
      });
    }
  }
  setDefault(Address address) {
    API.checkInternet().then((internet) {
      loading.value = true;
      if(internet) {
        API.setAddressDefault(address.id).then((value) {
          getAddress();
        });
      }else {
        Get.to(() => NoInternet())!.then((value) {
          setDefault(address);
        });
      }
    });
  }
  getAddress() {
    API.checkInternet().then((internet) {
      if(internet) {
        loading.value = true;
        API.getAddress().then((value) {
          if(value.isNotEmpty) {
            addresses.clear();
            addresses.addAll(value);
            loading.value = false;
            clear();
          }else{
            loading.value = false;
          }
        }).catchError((err){
        });
      }else {
        Get.to(() => NoInternet())!.then((value) {
          getAddress();
        });
      }
    });
  }
  deleteAddress(BuildContext context,Address address) {
    API.checkInternet().then((internet) {
      if(internet) {
        loading.value = true;
        API.deleteAddress(address.id).then((value) {
          addresses.remove(address);
          loading.value = false;
        });
      }else {
        Get.to(() => NoInternet())!.then((value) {
          deleteAddress(context,address);
        });
      }
    });
  }
  editAddress(BuildContext context,String nickName,int defaultAddress,String adrs1,String adrs2,String apartment,String phone,String country,String emirate,int id) {
    loading.value = true;
    API.checkInternet().then((internet) {
      if(internet) {
        API.editAddress(nickName,defaultAddress,adrs1,adrs2,apartment,phone,emirate,country,id).then((value) {
        }).then((value) {
          AppStyle.successMsg(context,"address edit successfully");
          loading.value = false;
          Get.back();
          getAddress();
        });
      }else{
        Get.to(() => NoInternet())!.then((value) {
          editAddress(context,nickName,defaultAddress,adrs1,adrs2,apartment,phone,country,emirate,id);
        });
      }
    });
  }
  clear() {
    nickName.clear();
    adddress1.clear();
    adddress2.clear();
    apartment.clear();
    phone.clear();
    country="non".obs;
    emirate="non".obs;
    nickNameValidate = true.obs;
    address1Validate = true.obs;
    address2Validate = true.obs;
    apartmentValidate = true.obs;
    countryValidate = true.obs;
    emirateValidate = true.obs;
    phoneValidate = true.obs;
    defaultAddress = 0.obs;
    defaultValidate = false.obs;
  }

}