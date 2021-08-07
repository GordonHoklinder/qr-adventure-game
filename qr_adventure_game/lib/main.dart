import 'package:flutter/material.dart';


import 'controllers/navigator.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Adventura',
      theme: ThemeData(
        primaryColor: Colors.brown[400],
        iconTheme: IconThemeData(
          //color: Colors.white,
          color: Colors.amberAccent,
          size: 60,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
          bodyText2: TextStyle(
            //color: Colors.white,
            color: Colors.black,
            fontSize: 40,
          )
        )
      ),
      initialRoute: 'home',
      routes: navigation,
    );
  }
}

