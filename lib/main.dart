import 'package:flutter/material.dart';

import './homeScreen.dart';
import './newsList.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    ));
}

