import 'package:flutter/material.dart';

import './newsList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // body: Center(child: Text('Hello',style: TextStyle(fontSize: 50),))
        body: NewsList(),
      ),
    );
  }
}