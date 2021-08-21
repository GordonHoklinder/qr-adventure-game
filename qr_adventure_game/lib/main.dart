import 'package:flutter/material.dart';
import 'package:qr_adventure_game/routes/route_generator.dart';

import 'controllers/navigator.dart';

// Here set the colors of the app.
const primaryColor = Colors.blue;
const contrastColor = Colors.white;

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
        primaryColor: primaryColor,
        iconTheme: IconThemeData(
          //color: Colors.white,
          color: primaryColor,
          size: 60,
        ),
        textTheme: TextTheme(
            bodyText1: TextStyle(
              color: contrastColor,
              fontSize: 20,
            ),
            bodyText2: TextStyle(
              //color: Colors.white,
              color: Colors.black,
              fontSize: 20,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: primaryColor),
        ),
      ),
      initialRoute: 'home',
      onGenerateRoute: routeGenerator,
      routes: navigation,
    );
  }
}
