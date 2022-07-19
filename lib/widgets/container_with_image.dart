import 'package:bk9/const/app-style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ContainerWithImage extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final int option; /// 0 SVG /// 1 png


  const ContainerWithImage({
    required this.width,
    required this.height,
    required this.image,
    required this.option
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: option == 0 ? SvgPicture.asset(image,fit: BoxFit.cover,) : Image.asset(image, fit: BoxFit.cover,)
    );
  }
}