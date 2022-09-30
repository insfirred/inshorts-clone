import 'package:flutter/material.dart';

Widget  AnimatedButton() {
  return Container(
    height: 70,
    width: 200,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 12.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff33ccff),
            Color(0xffff99cc),
          ],
        )),
    child: Center(
      child: Text(
        'Press',
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    ),
  );
}