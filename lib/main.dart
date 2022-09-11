import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './HomeScreen.dart';
import './Screens/gettingStarted.dart';
import './theme/theme.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome')??false;
  runApp(
    MyApp(showHome: showHome)
  );
}

class MyApp extends StatelessWidget {
  final bool showHome;
  MyApp({
    Key? key,
    required this.showHome
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Shorts',
      themeMode: ThemeMode.system,
      // theme: ThemeData.light(),
      theme: lightTheme,
      darkTheme: darkTheme,
      home: showHome ?HomeScreen() :GettingStarted(),
    );
  }
}