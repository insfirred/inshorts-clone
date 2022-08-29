import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './HomeScreen.dart';
import './Screens/gettingStarted.dart';

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
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: showHome ?HomeScreen() :GettingStarted(),
    );
  }
}