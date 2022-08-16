import 'package:bk9/view/intro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ///from maya 8/15
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'K9',
      debugShowCheckedModeBanner: false,
      home: Intro()
    );
  }
}

