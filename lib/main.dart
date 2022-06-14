import 'package:flutter/material.dart';

import './Screens/bookmarks.dart';
import './Screens/newsList.dart';
import './Screens/webView.dart';

void main() {
  var controller = PageController(initialPage: 1);
  runApp(MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SafeArea(
      child: Scaffold(
        body: PageView(
          controller: controller,
          children: [
            Bookmarks(),
            NewsList(),
            WebView(),
          ],
        ),
      ),
    ),
    ));
}

