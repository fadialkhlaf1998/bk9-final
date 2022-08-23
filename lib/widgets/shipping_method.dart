import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ShippingMethod extends StatelessWidget {

  final Callback onTap;
  final Color color;
  final BoxShadow boxShadow;
  final Widget child1;
  final Widget child2;
  final Widget child3;

  const ShippingMethod({
    required this.onTap,
    required this.color,
    required this.boxShadow,
    required this.child1,
    required this.child2,
    required this.child3
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
           boxShadow
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  child1,
                  child2
                ],
              ),
              SizedBox(height: 5,),
              child3
            ],
          ),
        )
      ),
    );
  }
}