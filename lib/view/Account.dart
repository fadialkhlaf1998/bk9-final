import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/const/store.dart';
import 'package:bk9/controller/account_controller.dart';
import 'package:bk9/controller/addresses_controller.dart';
import 'package:bk9/controller/main_page_controller.dart';
import 'package:bk9/view/FAQ.dart';
import 'package:bk9/view/change_password.dart';
import 'package:bk9/view/login.dart';
import 'package:bk9/view/signup.dart';
import 'package:bk9/view/wishlist.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/custom_button.dart';
import 'package:bk9/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  Account({Key? key}) : super(key: key);

  MainPageController mainPageController = Get.find();
  AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Stack(
          children: [
            BackgroundImage(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _header(context),
                  SizedBox(height: 10,),
                  _body(context),
                  SizedBox(height: 20,)
                ],
              ),
            ),
            accountController.loading.value ?
            Positioned(child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(color: AppStyle.primary,),
              ),
            )) : Center()
          ],
        ))
    );
  }

  _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: AppStyle.getDeviceWidthPercent(100, context),
      height: AppStyle.getDeviceHeightPercent(9, context),
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
          GestureDetector(
              onTap: () {
                mainPageController.changeIndexOfBottomBar(0);
              },
              child: Icon(Icons.arrow_back,size: 23,)
          ),
          SizedBox(width: 80),
          Container(
            width: AppStyle.getDeviceWidthPercent(45, context),
            child: const Text("Account",
                maxLines: 2,
                style: TextStyle(
                  fontSize: CommonTextStyle.mediumTextStyle,
                  color: AppStyle.grey,
                  fontWeight: FontWeight.bold,
                )
            ),
          ),
          Icon(Icons.arrow_back,size: 25,color: Colors.transparent,)
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return API.customer_id == -1 ? notLogin(context) : login(context);
  }
  notLogin(BuildContext context) {
    return Column(
      children: [
        TextApp(
            text: "Sign In to see your account. Track your orders.",
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(8, context),
            textStyle: CommonTextStyle.textStyleForDarkGreySmallButtonBold
        ),
        SvgPicture.asset("assets/icons/account.svg",color: Colors.grey,width: 50,height: 50,),
        SizedBox(height: 18),
        CustomButton(
            text: "Login",
            onPressed: () {
              Get.off(() => Login());
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
        SizedBox(height: 20),
        Container(
          width: AppStyle.getDeviceWidthPercent(80, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don’t have an account? ",
                  style: TextStyle(
                      color: AppStyle.grey,
                      fontSize: 15
                  )
              ),
              GestureDetector(
                onTap: () {
                  Get.off(()=> SignUp());
                },
                child: Text("Sign Up",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    )
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: AppStyle.getDeviceWidthPercent(85, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  text: "Track Order",
                  onPressed: () {
                    ///
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
              CustomButton(
                  text: "About Us",
                  onPressed: () {
                    ///
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
            ],
          ),
        ),
        Container(
          width: AppStyle.getDeviceWidthPercent(85, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  text: "Shipping Order",
                  onPressed: () {
                    ///
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
              CustomButton(
                  text: "Articles",
                  onPressed: () {
                    ///
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
            ],
          ),
        ),
        Container(
          width: AppStyle.getDeviceWidthPercent(85, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  text: "Return & Exchange",
                  onPressed: () {
                    ///
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
              CustomButton(
                  text: "Offers",
                  onPressed: () {
                    ///
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
            ],
          ),
        ),
        Container(
          width: AppStyle.getDeviceWidthPercent(85, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  text: "FAQ's",
                  onPressed: () {
                    Get.to(() => FAQ());
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
              CustomButton(
                  text: "Store Location",
                  onPressed: () {
                    ///
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
            ],
          ),
        ),
        Container(
          width: AppStyle.getDeviceWidthPercent(85, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  text: "Terms & Conditions",
                  onPressed: () {
                    ///
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
              CustomButton(
                  text: "Contact Us",
                  onPressed: () {
                    ///
                  },
                  color: AppStyle.greyButton,
                  borderRadius: 30,
                  border: Colors.transparent,
                  width: AppStyle.getDeviceWidthPercent(40, context),
                  height: AppStyle.getDeviceHeightPercent(5, context),
                  textStyle: CommonTextStyle.textStyleForGreySmallButton
              ),
            ],
          ),
        ),
      ],
    );
  }
  login(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                API.customer!.image.length == 0 ?
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person,color: AppStyle.grey,size: 75,)
                ) :
                GestureDetector(
                  onTap: () =>
                      showProfileImage(context),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(API
                                .media_url +
                                API.customer!.image),
                            fit: BoxFit.cover)
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      profileBottomSheet(context);
                    },
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: AppStyle.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit,color: Colors.white,size: 20)
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hi, " + API.customer!.firstname + "!",
                  style: CommonTextStyle.textStyleForDarkGreySmallButtonBold,
                ),
                SizedBox(height: 10,),
                Text("Manage your profile details here",
                    style: TextStyle(
                        color: AppStyle.grey,
                        fontSize: CommonTextStyle.tinyTextStyle,
                        fontWeight: FontWeight.normal
                    )
                ),
              ],
            ),
          ],
        ),
        // Container(
        //   width: AppStyle.getDeviceWidthPercent(87, context),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       API.customer!.image.length == 0 ?
        //       SvgPicture.asset("assets/icons/account.svg",color: Colors.grey,width: 50,height: 50,) :
        //       Container(
        //         width: 70,
        //         height: 70,
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             image: DecorationImage(
        //                 image: NetworkImage(API
        //                     .media_url +
        //                     API.customer!.image),
        //                 fit: BoxFit.cover)
        //         ),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text("Hi, " + API.customer!.firstname + "!",
        //             style: CommonTextStyle.textStyleForDarkGreySmallButtonBold,
        //           ),
        //           SizedBox(height: 10,),
        //           Text("Manage your profile details here",
        //             style: TextStyle(
        //                 color: AppStyle.grey,
        //                 fontSize: CommonTextStyle.tinyTextStyle,
        //                 fontWeight: FontWeight.normal
        //             )
        //           ),
        //         ],
        //       ),
        //       SizedBox(width: 20,),
        //       GestureDetector(
        //         onTap: () {
        //           profileBottomSheet(context);
        //         },
        //         child: Text("Edit",
        //             style: TextStyle(
        //               decoration: TextDecoration.underline,
        //                 color: Colors.blue,
        //                 fontSize: CommonTextStyle.mediumTextStyle,
        //                 fontWeight: FontWeight.bold
        //             )
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        SizedBox(height: 25),
        CustomButton(
            text: "Order History",
            onPressed: () {
              accountController.getOrderHistory(context);
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
        CustomButton(
            text: "My Returns",
            onPressed: () {
              ///
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
        CustomButton(
            text: "My Addresses",
            onPressed: () {
              accountController.getAddress();
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
        CustomButton(
            text: "My Wishlist",
            onPressed: () {
              Get.to(() => Wishlist());
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
        CustomButton(
            text: "My Payments",
            onPressed: () {
              ///
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
        CustomButton(
            text: "My Vouchers",
            onPressed: () {
              ///
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
        CustomButton(
            text: "Change Password",
            onPressed: () {
              Get.to(() => ChangePassword());
            },
            color: AppStyle.primary,
            borderRadius: 30,
            border: Colors.transparent,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForOrangeMediumButtonBold
        ),
        SizedBox(height: 20),
        CustomButton(
            text: "Log Out",
            onPressed: () {
              Store.logout();
            },
            color: Colors.white,
            borderRadius: 30,
            border: AppStyle.primary,
            width: AppStyle.getDeviceWidthPercent(80, context),
            height: AppStyle.getDeviceHeightPercent(6.5, context),
            textStyle: CommonTextStyle.textStyleForWhiteMediumButton
        ),
      ],
    );
  }
  showProfileImage(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, __, ___) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppStyle.getDeviceWidthPercent(80, context),
              height: AppStyle.getDeviceHeightPercent(40, context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(API
                          .media_url +
                          API.customer!.image),
                      fit: BoxFit.cover)
              ),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
  profileBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
          height: AppStyle.getDeviceHeightPercent(21, context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Profile Photo",
                      style: CommonTextStyle.textStyleForDarkGreyBigButton,
                    ),
                    GestureDetector(
                      onTap: () {
                        accountController.deleteImage();
                      },
                      child: Icon(Icons.delete,size: 23,color: AppStyle.grey,),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            accountController.pickGalleyImage();
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppStyle.primary
                            ),
                            child: Center(
                              child: Icon(Icons.image,size: 30,color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Center(
                          child: Text("Gallery",
                              style: TextStyle(
                                  color: AppStyle.darkGrey,
                                  fontSize: CommonTextStyle.smallTextStyle
                              )
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 30,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            accountController.pickCameraImage();
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppStyle.primary
                            ),
                            child: Center(
                              child: Icon(Icons.camera_alt,size: 30,color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Center(
                          child: Text("Camera",
                              style: TextStyle(
                                  color: AppStyle.darkGrey,
                                  fontSize: CommonTextStyle.smallTextStyle
                              )
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}