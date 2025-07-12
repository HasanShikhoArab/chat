import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constes.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key,required this.text1,required this.ontap});
String?text1;
VoidCallback?ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container (
        width: double.infinity,
        height: 60,
        child: Center(child: Text('$text1',style: TextStyle(color: kprimaryColor.shade900),),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
      ),
    );
  }
}
