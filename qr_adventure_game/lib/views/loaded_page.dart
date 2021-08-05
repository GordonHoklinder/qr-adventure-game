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
          Image.asset(
            'assets/detectivePhoto.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top,),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => {Navigator.pushNamed(context, 'itinerary')},
                        iconSize: Theme.of(context).iconTheme.size as double,
                        icon: Icon(
                          Icons.widgets_rounded,
                          color: Theme.of(context).iconTheme.color,
                        )
                    ),
                    IconButton(
                        onPressed: () => {Navigator.pushNamed(context, 'qr_scan')},
                        iconSize: Theme.of(context).iconTheme.size as double,
                        icon: Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Theme.of(context).iconTheme.color,
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
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
