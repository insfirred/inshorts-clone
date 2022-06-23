import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../HomeScreen.dart';

import './newsList.dart';

class WebViewPage extends StatefulWidget {
  // const WebViewPage({Key? key}) : super(key: key);
  var jsonData;
  WebViewPage(this.jsonData);

  @override
  State<WebViewPage> createState() => _WebViewPageState(jsonData);
}

class _WebViewPageState extends State<WebViewPage> {
  var jsonData;
  _WebViewPageState(this.jsonData);

  void action(String choice) {
    print('Working...');
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Widget TopBar() {
    return Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: 35,
        child: Align(
          alignment: Alignment.centerRight,
          child: PopupMenuButton<String>(
              onSelected: action,
              itemBuilder: (context) {
                return PopUpMenuData.Menu.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }),
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          Expanded(
            child: WebView(
              // initialUrl: jsonData["articles"][0]["url"],
              initialUrl: jsonData["articles"][HomeScreen.newsIndex]["url"],
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}

class PopUpMenuData {
  static const String copyLink = 'Copy link';
  static const String browser = 'Open in browser';

  static const List<String> Menu = <String>[
    copyLink,
    browser,
  ];
}
