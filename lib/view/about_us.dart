import 'package:bk9/const/api.dart';
import 'package:bk9/const/app-style.dart';
import 'package:bk9/const/store.dart';
import 'package:bk9/controller/account_controller.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/widgets/background_image.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {

  IntroController introController = Get.find();
  AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _header(context),
                    SizedBox(height: 20),
                    _body(context),
                  ],
                ),
              ),
            ],
          ),
        )
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
            child: Text("About Us",
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
      children: [
        Container(
          width: AppStyle.getDeviceWidthPercent(100, context),
          height: AppStyle.getDeviceHeightPercent(25, context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(introController.aboutPage!.image!),
              fit: BoxFit.cover
            )
          ),
        ),
        TextApp(
            text: "ABOUT US",
            width: AppStyle.getDeviceWidthPercent(100, context),
            height: 50,
            textStyle: CommonTextStyle.textStyleForWhiteBigButton
        ),
        Container(
          width: AppStyle.getDeviceWidthPercent(90, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width:  AppStyle.getDeviceWidthPercent(100, context),
                child: Text(introController.aboutPage!.jsonData![0].data,
                  style: CommonTextStyle.textStyleForDarkGreySmallButtonNormal
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(introController.aboutPage!.jsonData![1].data,
                    style: CommonTextStyle.textStyleForDarkGreySmallButtonNormal
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(introController.aboutPage!.jsonData![2].data,
                    style: CommonTextStyle.textStyleForDarkGreySmallButtonNormal
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Stack(
          children: [
            Positioned(
              child: Container(
                height: AppStyle.getDeviceHeightPercent(30, context),
                child: GoogleMap(
                  mapType: MapType.normal,
                  zoomGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: accountController.onMapCreated,
                  markers: accountController.marker,
                  initialCameraPosition: accountController.initialCameraPosition,
                ),
              ),),
            GestureDetector(
              onTap: (){
                accountController.openMap(Store.latitude, Store.longitude);
              },
              child: Container(
                height: AppStyle.getDeviceHeightPercent(30, context),
                color: Colors.transparent,
              ),
            ),
          ],
        ),
        Container(
          width: AppStyle.getDeviceWidthPercent(100, context),
          color: AppStyle.green,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: AppStyle.getDeviceWidthPercent(90, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_pin,color: Colors.white,size: 23,),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Warehouse S01, Ras Al Khor 2",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: CommonTextStyle.smallTextStyle
                              )
                          ),
                          SizedBox(height: 5),
                          Text("Dubai, United Arab Emirates",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: CommonTextStyle.smallTextStyle
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.call,color: Colors.white,size: 23,),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if(await canLaunchUrl(Uri.parse('tel: +971 04 333 5843'))){
                                await launchUrl (Uri.parse('tel: +971 04 333 5843'));
                              }
                            },
                            child: Text("+971 04 333 5843",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: CommonTextStyle.smallTextStyle
                                )
                            )
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () async {
                              if(await canLaunchUrl(Uri.parse('tel: +971 54 204 6700'))){
                                await launchUrl (Uri.parse('tel: +971 54 204 6700'));
                              }
                            },
                            child: Text("+971 54 204 6700",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: CommonTextStyle.smallTextStyle
                                )
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  socialMedia(context)
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
  socialMedia(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: AppStyle.getDeviceWidthPercent(50, context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              AppStyle.lunchURL(context,"https://www.instagram.com/thebarkley.ae/");
            },
            child: SvgPicture.asset("assets/icons/instagram.svg",width: 18,height: 18,color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              AppStyle.lunchURL(context, "https://www.facebook.com/thebarkley.ae");
            },
            child: SvgPicture.asset("assets/icons/facebook.svg",width: 18,height: 18,color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              AppStyle.lunchURL(context, "https://twitter.com/luxurycarsdxb");
            },
            child: SvgPicture.asset("assets/icons/tiktok.svg",width: 16,height: 16,color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              AppStyle.lunchURL(context, "https://www.youtube.com/channel/UCbo7v4tCiUVIfptpWqTGg-A");
            },
            child: SvgPicture.asset("assets/icons/youtube.svg",width: 16,height: 16,color: Colors.white),
          ),
        ],
      ),
    );
  }


}