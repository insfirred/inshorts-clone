import 'package:flutter/material.dart';

// Light Theme
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,

  textTheme: TextTheme(
    subtitle1: TextStyle(color: Colors.grey[700],fontSize: 17),
    subtitle2: const TextStyle(color: Colors.grey,fontSize: 14,fontStyle: FontStyle.italic),
    headline5: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black),
    headline6: const TextStyle(color: Colors.black)
  ),

  iconTheme: const IconThemeData(color: Colors.black87),

  primaryColor: Colors.grey[300]
);


// Dark Theme
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[900],

  textTheme: TextTheme(
    subtitle1: TextStyle(color: Colors.grey[300],fontSize: 17),
    subtitle2: const TextStyle(color: Colors.grey,fontSize: 14,fontStyle: FontStyle.italic),
    headline5: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
    headline6: const TextStyle(color: Colors.white)
  ),

  iconTheme: const IconThemeData(color: Colors.white70),

  primaryColor: Colors.grey[800]
);