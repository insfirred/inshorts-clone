import 'package:flutter/material.dart';

// Light Theme
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Color.fromARGB(255, 253, 230, 230),

  textTheme: TextTheme(
    subtitle1: TextStyle(color: Colors.grey[700],fontSize: 17),
    subtitle2: const TextStyle(color: Colors.grey,fontSize: 12,fontStyle: FontStyle.italic),
    headline5: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black, fontFamily: 'Roboto'),
    headline6: const TextStyle(color: Colors.black, fontSize: 17),
    headline4: const TextStyle(color: Colors.black, fontSize: 28)
  ),

  iconTheme: const IconThemeData(color: Colors.black87),

  // primaryColor: Color.fromARGB(0, 202, 134, 134)
  primaryColor: Color.fromARGB(189, 230, 183, 183)
);


// Dark Theme
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color.fromRGBO(26, 27, 34, 1),

  textTheme: TextTheme(
    subtitle1: TextStyle(color: Colors.grey[300],fontSize: 17),
    subtitle2: const TextStyle(color: Colors.grey,fontSize: 12,fontStyle: FontStyle.italic),
    headline5: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white, fontFamily: 'Roboto'),
    headline6: const TextStyle(color: Colors.white, fontSize: 17),
    headline4: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.75), fontSize: 28)
  ),

  iconTheme: const IconThemeData(color: Colors.white70),

  // primaryColor: Colors.grey[800]
  primaryColor: Color.fromRGBO(0, 0, 0, 0.3)
);