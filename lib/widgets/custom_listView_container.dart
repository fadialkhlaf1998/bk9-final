import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/intro_controller.dart';
import 'package:bk9/widgets/container_with_image.dart';
import 'package:bk9/widgets/custom_container.dart';
import 'package:bk9/widgets/text_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListViewContainer extends StatelessWidget {
  final double width;
  final double height;
  final List<Object> myList;
  final VoidCallback onTap;
  final IntroController introController;


  const CustomListViewContainer({
    required this.myList,
    required this.onTap,
    required this.width,
    required this.height,
    required this.introController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppStyle.getDeviceWidthPercent(90, context),
        height: height,
        child: ListView.builder(
          itemCount: (introController.events.length/2).toInt(),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index) {
            return GestureDetector(
                onTap: () => onTap,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: NetworkImage(introController.events[index].image!),
                        fit: BoxFit.cover
                      )
                    ),
                  )
                ),
            );
          },
        )
    );
  }
}
