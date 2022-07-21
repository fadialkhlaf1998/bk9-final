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
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: AppStyle.getDeviceWidthPercent(100, context),
      height: AppStyle.getDeviceHeightPercent(16, context),
      color: AppStyle.lightGrey,
      child: Column(
        children: [
          TextApp(
              text: "Brands",
              width: AppStyle.getDeviceWidthPercent(100, context),
              height: AppStyle.getDeviceHeightPercent(5, context),
              textStyle: CommonTextStyle.textStyleForDarkGreyBigButton
          ),
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
                      introController.get_products_by_brand(introController.brand[index].id, context);
                    },
                    child:  Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle
                      ),
                      child: Container(
                        width: AppStyle.getDeviceWidthPercent(21, context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Image.network(introController.brand[index].image!,
                            fit: BoxFit.contain,),
                        )
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
