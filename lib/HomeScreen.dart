import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inshorts_clone/database/database.dart';
import 'package:sqflite/sqflite.dart';

import './Screens/waitingScreen.dart';
import './Screens/bookmarks.dart';
import './Screens/newsList.dart';
import './Screens/webView.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static int newsIndex = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController controller;

  String url = "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=ff7aefdd16e6480faf2817f36e2daa5e";

  late var jsonData;

  bool isNewsFetched = false;

  void fetchNews() async{
    var response = await http.get(Uri.parse(url));
    var news = json.decode(response.body);
    jsonData = news;
    if(news != null){
      isNewsFetched = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 1);
    fetchNews();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isNewsFetched
        ?PageView(
          controller: controller,
          children: [
            Bookmarks(),
            NewsList(jsonData),
            WebViewPage(jsonData)
          ],
        )
        :const WaitingScreen()
      ),
      
    );
  }
}