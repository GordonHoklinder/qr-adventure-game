import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: Image.asset(
              'assets/detectivePhoto.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          /// navigation bar
          Align(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ]
                ),
              ]
            )
          )
        ]
      )
    );
  }
}