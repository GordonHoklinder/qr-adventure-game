import 'package:flutter/material.dart';
import '../controllers/itinerary.dart';
import '../controllers/parser.dart';
import '../controllers/parser_funcs.dart';

/// The page which is scanned from a QR code.
class LoadedPage extends StatelessWidget {
  final String code;
  LoadedPage(this.code);


  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      body: Stack(
        children: [
          // Here goes navigation bar.
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // The subtracted number shall be bound to a variable
              // with size of the navbar.
              height: MediaQuery.of(context).size.height - 50,
              child: Column(
                children: parseCode(code),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
