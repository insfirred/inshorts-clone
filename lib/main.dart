import 'package:flutter/material.dart';

import './HomeScreen.dart';
import './Screens/gettingStarted.dart';

void main() {

  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/getting_started': (context) => GettingStarted(),
      },
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // home: HomeScreen(),
    );
  }
}