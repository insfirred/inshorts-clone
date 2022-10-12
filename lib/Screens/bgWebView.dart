import 'package:flutter/material.dart';

import './webView.dart';

class TestWebView extends StatefulWidget {
  // const TestWebView({super.key});
  var jsonData;
  TestWebView(this.jsonData);

  @override
  State<TestWebView> createState() => _TestWebViewState();
}

class _TestWebViewState extends State<TestWebView> {

  @override
  void initState() {
    // TODO: implement initState
    // Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(widget.jsonData)));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WebViewPage(widget.jsonData)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}