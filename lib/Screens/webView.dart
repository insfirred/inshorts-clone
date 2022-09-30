import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../HomeScreen.dart';

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

  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: WebView(
        initialUrl: jsonData["articles"][HomeScreen.newsIndex]["url"],
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
