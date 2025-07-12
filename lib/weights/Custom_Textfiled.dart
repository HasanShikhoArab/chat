import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFild extends StatelessWidget {
   CustomTextFild({super.key,required this.hinText,required this.onchange,this.obs=false});
String?hinText;
bool?obs;
Function(String)?onchange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value!.isEmpty){
          return 'is requried';
        }
      },
      onChanged: onchange,
      obscureText: obs!,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: '$hinText',
        hintStyle: TextStyle(color: Colors.white,fontSize: 16),
        border: OutlineInputBorder(

        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
