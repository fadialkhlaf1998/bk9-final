import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/widgets/text_app.dart';
import 'package:flutter/material.dart';

class CustomListViewBrands extends StatelessWidget {

  final IntroController introController;


  const CustomListViewBrands({
    required this.introController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: AppStyle.getDeviceWidthPercent(100, context),
      height: AppStyle.getDeviceHeightPercent(16, context)+20,
      color: AppStyle.lightGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppStyle.getDeviceWidthPercent(90, context),
                child: Text("Shop By Brands",
                    style: CommonTextStyle.textStyleForDarkGreyBigButton
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Container(
            width: AppStyle.getDeviceWidthPercent(100, context),
            height: AppStyle.getDeviceHeightPercent(10, context),
            child: ListView.builder(
              itemCount: introController.brand.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index) {
                return GestureDetector(
                    onTap: () {
                      introController.shopByBrand(context,introController.brand[index].id,introController.brand[index].title.toString());
                    },
                    child:  Container(
                      padding: EdgeInsets.all(4),
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
              },
            ),
          )
        ],
      )
    );
  }
}
