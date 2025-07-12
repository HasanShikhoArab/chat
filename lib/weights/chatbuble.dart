
import 'package:chat/moudels/messagemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constes.dart';

class chatbubble extends StatelessWidget {
  const chatbubble({
    super.key, required this.message,
  });
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(

        margin: EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
            color: kprimaryColor.shade700,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20))),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }}





class chatbubble2 extends StatelessWidget {
  const chatbubble2({
    super.key, required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(

        margin: EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
            color:kprimaryColor.shade800,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20))),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }}