import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/view/services_details.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGridViewServices extends StatelessWidget {

  final int count;
  final mainAxisSpacing;
  final crossAxisSpacing;
  final double childAspectRatio;

  final double? containerPadding;
  final double padding;
  final IntroController introController;

  const CustomGridViewServices({
    required this.count,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.childAspectRatio,
    this.containerPadding,
    required this.padding,
    required this.introController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: childAspectRatio
        ),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: introController.service.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap:  (){
                Get.to(()=>ServicesDetails(introController.service[index]));
              },
              child: Container(
                padding: EdgeInsets.all(containerPadding == null ?
                0.0 : containerPadding!),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: "service" + introController.service[index].id.toString(),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)
                              ),
                              image: DecorationImage(
                                image: NetworkImage(introController.service[index].image!),
                                fit: BoxFit.cover
                              ),
                            ),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: padding),
                                child: Text(introController.service[index].title!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: CommonTextStyle.tinyTextStyle
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
          );
        });
  }
}
