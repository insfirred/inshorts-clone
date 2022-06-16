import 'package:flutter/material.dart';

import './HomeScreen.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    ));
}